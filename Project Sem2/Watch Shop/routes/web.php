<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CartController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\BrandController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\AdminRoleController;
use App\Http\Controllers\AdminSaleController;
use App\Http\Controllers\AdminUserController;
use App\Http\Controllers\AdminOrdersController;
use App\Http\Controllers\AdminProductController;
use App\Http\Controllers\OrdersController;
use App\Http\Controllers\AdminPermissionController;
use Illuminate\Support\Facades\Session;


//CLIENT
// Search
Route::get("search", [ProductController::class, 'search']);
//home
Route::get('/home', 'HomeController@getIndex')->name('home');
//category
Route::get('/product-by-cate/{category_id}', 'CategoryController@ProductByCategory')->name('cate-product');
//brand
Route::get('/all-product-by-brand', 'BrandController@AllBrandProduct')->name('brand-product');
Route::get('/product-by-brand/{brand_id}', 'BrandController@ProductByBrand');
//product
Route::get('/product-details/{product_id}', 'ProductController@ProductDetail');
//cart
Route::get('/show-cart', 'CartController@showCart');
Route::get('/add-to-cart/{id}', 'CartController@addToCart');
Route::get('/delete-cart-item/{rowId}', 'CartController@deleteItem');
Route::post('/update-quantity', 'CartController@updateQuantity')->name('update-quantity');
Route::post('/update-quantity-product', 'CartController@updateQuantityProduct')->name('update-quantity-product');
//checkout
Route::get('/checkout', 'CartController@checkout');
Route::post('/store-shipping-information', 'CartController@saveShipDetail');
Route::get('/success', 'CartController@success');

//login-register
Route::get('/home', 'HomeController@getIndex');
Route::get('/user/login', function () {
    return view('pages.login');
});
Route::post('/user/login', 'HomeController@userLogin');
Route::post('/user/register', 'HomeController@registeruser');
Route::view('/user/register','pages.register');
Route::get('/user/logout', 'HomeController@logoutuser');


//user orders
Route::get('/user/orders','OrdersController@orders');
//user view order details
Route::get('/user/orders/{id}','OrdersController@orderDetails');

//admin
Route::get('/admin_home', 'HomeController@AdminHome')->middleware('can:admin-home');

Route::get('/admin/login', 'HomeController@getLoginAdmin')->name('admin');
Route::post('/admin/login', 'HomeController@postLoginAdmin')->name('admin.login');
Route::get('/admin/logout', 'HomeController@logout')->name('admin.logout');

// category
Route::prefix('admin')->group(function () {

    //create category by admin
    Route::prefix('categories')->group(function () {

        Route::get('/', [CategoryController::class, 'adminIndexCate'])->name('categories.index')->middleware('can:category-list');

        Route::get('/adminCreateCate', [CategoryController::class, 'adminCreateCate'])->name('categories.create')->middleware('can:category-add');

        route::post('/store', [CategoryController::class, 'store'])->name('categories.store');

        route::get('/edit/{id}/', [CategoryController::class, 'edit'])->name('categories.edit')->middleware('can:category-edit');

        route::post('/update/{id}', [CategoryController::class, 'update'])->name('categories.update');

        route::get('/delete/{id}', [CategoryController::class, 'delete'])->name('categories.delete')->middleware('can:category-delete');
    });

    //brand
    Route::prefix('brands')->group(function () {

        Route::get('/', 'BrandController@index')->name('brands.index')->middleware('can:brand-list');

        Route::get('/addBrand', [BrandController::class, 'addBrand'])->name('brands.create')->middleware('can:brand-add');

        route::post('/store', [BrandController::class, 'store'])->name("brands.store");

        route::get('/edit/{id}', [BrandController::class, 'edit'])->name("brands.edit")->middleware('can:brand-edit');

        route::post('/update/{id}', [BrandController::class, 'update'])->name("brands.update");

        route::get('/delete/{id}', [BrandController::class, 'delete'])->name("brands.delete")->middleware('can:brand-delete');
    });

    //product
    Route::prefix('products')->group(function () {

        Route::get('/', 'AdminProductController@index')->name('product.index')->middleware('can:product-list');

        Route::get('/create', [AdminProductController::class, 'create'])->name('product.create')->middleware('can:product-add');

        Route::post('/store', [AdminProductController::class, 'store'])->name('product.store');

        Route::get('/edit/{id}', [AdminProductController::class, 'edit'])->name('product.edit')->middleware('can:product-edit');

        Route::post('/update/{id}', [AdminProductController::class, 'update'])->name('product.update');

        Route::get('/delete/{id}', [AdminProductController::class, 'delete'])->name('product.delete')->middleware('can:product-delete');
    });

    //user
    Route::prefix('users')->group(function () {

        Route::get('/', 'AdminUserController@index')->name('users.index')->middleware('can:user-list');

        Route::get('/create', [AdminUserController::class, 'create'])->name('users.create')->middleware('can:user-add');

        Route::post('/store', [AdminUserController::class, 'store'])->name('users.store');

        Route::get('/edit/{id}', [AdminUserController::class, 'edit'])->name('users.edit')->middleware('can:user-edit');

        Route::post('/update/{id}', [AdminUserController::class, 'update'])->name('users.update');

        Route::get('/delete/{id}', [AdminUserController::class, 'delete'])->name('users.delete')->middleware('can:user-delete');
    });

    //roles
    Route::prefix('roles')->group(function () {

        Route::get('/', 'AdminRoleController@index')->name('roles.index')->middleware('can:role-list');

        Route::get('/create', [AdminRoleController::class, 'create'])->name('roles.create')->middleware('can:role-add');

        Route::post('/store', [AdminRoleController::class, 'store'])->name('roles.store');

        Route::get('/edit/{id}', [AdminRoleController::class, 'edit'])->name('roles.edit')->middleware('can:role-edit');

        Route::post('/update/{id}', [AdminRoleController::class, 'update'])->name('roles.update');

        Route::get('/delete/{id}', [AdminRoleController::class, 'delete'])->name('roles.delete')->middleware('can:role-delete');
    });

    //orders
    Route::prefix('orders')->group(function () {

        Route::get('/', 'AdminOrdersController@index')->name('orders.index')->middleware('can:order-list');

        Route::get('/edit/{id}', 'AdminOrdersController@edit')->name('orders.edit')->middleware('can:order-edit');

        Route::post('/update/{id}', [AdminOrdersController::class, 'update'])->name('orders.update');

        Route::get('/orderItemIndex/{id}', [AdminOrdersController::class, 'orderItemIndex'])->name('orders.indexOrderItem');

        Route::get('/editOrderItem/{id}', [AdminOrdersController::class, 'editOrderItem'])->name('orders.editOrderItem');

        Route::post('/updateOrderItem/{id}', [AdminOrdersController::class, 'updateOrderItem'])->name('orders.updateOrderItem');
    });

    //sale
    Route::prefix('sales')->group(function () {

        Route::get('/', 'AdminSaleController@index')->name('sales.index')->middleware('can:sale-list');

        // Route::get('/edit/{id}', 'AdminOrdersController@edit')->name('orders.edit')->middleware('can:order-edit');

        // Route::post('/update/{id}', [AdminOrdersController::class, 'update'])->name('orders.update');

        // Route::get('/orderItemIndex/{id}', [AdminOrdersController::class, 'orderItemIndex'])->name('orders.indexOrderItem');

        // Route::get('/editOrderItem/{id}', [AdminOrdersController::class, 'editOrderItem'])->name('orders.editOrderItem');

        // Route::post('/updateOrderItem/{id}', [AdminOrdersController::class, 'updateOrderItem'])->name('orders.updateOrderItem');
    });

    //permission
    Route::prefix('permission')->group(function () {

        Route::get('/create', [AdminPermissionController::class, 'createPermission'])->name('permissions.create')->middleware('can:permission-list');

        Route::post('/store', [AdminPermissionController::class, 'store'])->name('permissions.store');
    });
});
