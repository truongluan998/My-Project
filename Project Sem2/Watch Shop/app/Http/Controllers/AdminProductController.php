<?php

namespace App\Http\Controllers;

use App\Http\Requests\ProductAddRequest;
use App\Models\Brand;
use App\Models\Categories;
use App\Models\OrderItems;
use App\Models\Product;
use App\Models\ProductImage;
use App\Traits\DeleteModelTrait;
use App\Traits\StorageImageTrait;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;

class AdminProductController extends Controller
{

    use StorageImageTrait;
    use DeleteModelTrait;
    private $category;
    private $product;
    private $brand;
    private $orderItem;


    public function __construct(Categories $category, Brand $brand, Product $product, ProductImage $productImage, OrderItems $orderItem)
    {
        $this->category = $category;
        $this->product = $product;
        $this->productImage = $productImage;
        $this->brand = $brand;
        $this->orderItem = $orderItem;
    }

    public function index()
    {
        $products = $this->product->latest()->paginate(4);
        return \view('admin.product.index', compact('products'));
    }

    public function create()
    {
        $categories = $this->category->latest()->simplePaginate(0);
        $brands = $this->brand->latest()->simplePaginate(0);
        return \view('admin.product.add', compact('categories', 'brands'));
    }

    public function store(ProductAddRequest $request)
    {

        try {
            DB::beginTransaction();
            $dataProductCreate = [
                'name' => $request->name,
                'price' => $request->price,
                'content' => $request->descriptions,
                'category_id' => $request->category,
                'quantity' => $request->quantity,
                'brand_id' => $request->brand

            ];
            $dataUploadFeatureImage = $this->storageTraitUpload($request, 'feature_image', 'product');
            if (!empty($dataUploadFeatureImage)) {
                $dataProductCreate['feature_image_name'] = $dataUploadFeatureImage['file_name'];
                $dataProductCreate['feature_image'] = $dataUploadFeatureImage['file_path'];
            }
            $product = $this->product->create($dataProductCreate);


            // insert data product_image
            if ($request->hasFile('image_path')) {

                foreach ($request->image_path as $fileItem) {
                    $dataProductImageDetails = $this->storageTraitUploadMultiple($fileItem, 'product');
                    $product->productImages()->create([
                        'image_path' => $dataProductImageDetails['file_path'],
                        'image_name' => $dataProductImageDetails['file_name']
                    ]);
                }
            }
            DB::commit();
            return \redirect()->route('product.index');
        } catch (Exception $ex) {
            DB::rollback();
            Log::error('Message: ' . $ex->getMessage() . 'Line: ' . $ex->getLine());
        }
    }

    public function edit($id)
    {
        $product = $this->product->find($id);
        $categories = $this->category->all();
        $brands = $this->brand->all();
        return \view('admin.product.edit', compact('categories', 'brands', 'product'));
    }

    public function update(Request $request, $id)
    {
        try {
            DB::beginTransaction();
            $dataProductUpdate = [
                'name' => $request->name,
                'price' => $request->price,
                'content' => $request->descriptions,
                'category_id' => $request->category,
                'quantity' => $request->quantity,
                'brand_id' => $request->brand
            ];
            $dataUploadFeatureImage = $this->storageTraitUpload($request, 'feature_image', 'product');
            if (!empty($dataUploadFeatureImage)) {
                $dataProductUpdate['feature_image_name'] = $dataUploadFeatureImage['file_name'];
                $dataProductUpdate['feature_image'] = $dataUploadFeatureImage['file_path'];
            }
            $this->product->find($id)->update($dataProductUpdate);
            $product = $this->product->find($id);

            // insert data product_image
            if ($request->hasFile('image_path')) {
                $this->productImage->where('product_id', $id)->delete();
                foreach ($request->image_path as $fileItem) {
                    $dataProductImageDetails = $this->storageTraitUploadMultiple($fileItem, 'product');
                    $product->productImages() > create([
                        'image_path' => $dataProductImageDetails['file_path'],
                        'image_name' => $dataProductImageDetails['file_name']
                    ]);
                }
            }
            DB::commit();
            return \redirect()->route('product.index');
        } catch (Exception $ex) {
            DB::rollback();
            Log::error('Message: ' . $ex->getMessage() . 'Line: ' . $ex->getLine());
        }
    }

    public function delete($id)
    {
        $CountOrder = $this->getCountOrderItemByProduct($id);
        if ($CountOrder > 0) {
            \dd(1232);
        } else {
            return $this->deleteModelTrait($id, $this->product);
        }
    }

    public function getCountOrderItemByProduct($product_id)
    {
        $orderItem = OrderItems::where('product_id', $product_id)->with('orderItem')->count();
        return $orderItem;
    }
}
