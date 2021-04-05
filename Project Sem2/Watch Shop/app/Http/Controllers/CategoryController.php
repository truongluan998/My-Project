<?php

namespace App\Http\Controllers;

use App\Http\Requests\CategoriesAddRequest;
use App\Models\Brand;
use App\Models\Product;
use App\Models\Categories;
use App\Traits\DeleteModelTrait;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    private $category;
    use DeleteModelTrait;

    public function __construct(Categories $category, Product $product)
    {
        $this->category = $category;
        $this->product = $product;
    }

    public function ProductByCategory($category_id, Request $request)
    {
        $cate_name = Categories::all();
        $brand_name = Brand::all();
        $category = $request->category;
        $brand = $request->brand;
        if (isset($category)) {
            if (isset($brand)) {
                $cate = Product::whereIN('brand_id', explode(',', $brand))->whereIN('category_id', explode(',', $category))->paginate(6);
                response()->json($cate);
                return view('pages.productlist', compact('cate', 'cate_name', 'brand_name'));
            } else {
                $cate = Product::whereIN('category_id', explode(',', $category))->paginate(6);
                response()->json($cate);
                return view('pages.productlist', compact('cate', 'cate_name', 'brand_name'));
            }
        } else if (isset($brand)) {
            $cate = Product::whereIN('brand_id', explode(',', $brand))->where('category_id', $category_id)->paginate(6);
            response()->json($cate);
            return view('pages.productlist', compact('cate', 'cate_name', 'brand_name'));
        } else {
            $cate = Product::where('category_id', $category_id)->paginate(8);
            return view('pages.productlist', compact('cate', 'cate_name', 'brand_name'));
        }
        //dd($cate);
    }

    public function adminIndexCate()
    {
        $cate = $this->category->latest()->simplePaginate(5);
        return \view('admin.category.indexCate')->with('categories', $cate);
    }

    public function adminCreateCate()
    {
        return \view('admin.category.addCate');
    }

    public function store(CategoriesAddRequest $request)
    {
        $dataCategoriesCreate = [
            'name' => $request->name
        ];
        $this->category->create($dataCategoriesCreate);
        return \redirect()->route('categories.index');
    }

    public function edit($id)
    {

        $category = $this->category->find($id);
        return \view('admin.category.editCate', \compact('category'));
    }

    public function update(CategoriesAddRequest $request, $id)
    {
        $dateCategoriesUpdate = [
            'name' => $request->name
        ];
        $this->category->find($id)->update($dateCategoriesUpdate);
        return \redirect()->route('categories.index');
    }

    public function delete($id)
    {
        $countCate = $this->getCountCateByProduct($id);
        if ($countCate > 0) {
            \dd(1232);
        } else {
            return $this->deleteModelTrait($id, $this->category);
        }
    }

    public function getCountCateByProduct($category_id)
    {
        $cate = Product::where('category_id', $category_id)->with('category')->count();
        return $cate;
    }
}
