<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Brand;
use App\Models\Orders;
use App\Models\Product;
use App\Models\Categories;
use Illuminate\Http\Request;


use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;


class HomeController extends Controller
{


    private $brand;
    private $product;
    private $category;
    private $user;

    public function __construct(Brand $brand, User $user, Categories $category, Product $product)
    {
        $this->brand = $brand;
        $this->product = $product;
        $this->category = $category;
        $this->user = $user;
    }

    public function getIndex()
    {
        $new_product = Product::orderBy('created_at', 'asc')->limit(4)->get();
        //dd($new_product);
        return view('pages.home', compact('new_product'));
    }

    public function AdminHome()
    {

        $orders = Orders::select(DB::raw('count(*) as total '), DB::raw('DATE_FORMAT(created_at, "%Y-%m-%d") as created_date '))
            ->where('created_at', '>=', DB::raw('DATE(NOW()) - INTERVAL 7 DAY'))
            ->where('status', 1)
            ->groupBy('created_date')
            ->get();


        $brands = Brand::count();
        $products = Product::count();
        $categories = Categories::count();
        $users = User::count();

        return view('admin.admin_home', compact('brands', 'products', 'categories', 'users', 'orders'));
    }



    public function getLoginAdmin()
    {
        return view('admin.demoHtml.admin_login');
    }


    public function postLoginAdmin(Request $request)
    {

        $arr = [
            'username' => $request->username,
            'password' => $request->password
        ];

        if (Auth::attempt($arr)) {
            return \redirect()->to('admin_home');
        } else {
            return back()->with('error', 'Wrong Login!');
        }
    }


    public function userLogin(Request $req)
    {
        if ($req->isMethod('post')) {
            $data = $req->all();
            // echo "<pre>";print_r($data);die;
            if (Auth::attempt(['email' => $data['email'], 'password' => $data['password']])) {
                return redirect('/home');
            } else {
                $message = "invalid username or password";
                Session::flash('error_message', $message);
                return redirect()->back();
            }
        }
    }

    public function logout()
    {
        Auth::logout();
        return \redirect('/admin/login');
    }

    public function logoutuser()
    {
        Auth::logout();
        return redirect('/home');
    }

    function registeruser(Request $req)
    {
        if ($req->isMethod('post')) {
            $data = $req->all();
            // echo "<pre>";print_r($data);die;
            //check if user already exits
            $userCount = User::where('email', $data['email'])->count();
            if ($userCount > 0) {
                $message = "Email already exits";
                Session::flash('error_message', $message);
                return redirect()->back();
            } else {
                // register user
                $user = new User;
                $user->username = $data['username'];
                $user->email = $data['email'];
                $user->password = bcrypt($data['password']);
                $user->save();
                if (Auth::attempt(['email' => $data['email'], 'password' => $data['password']])) {
                    return redirect('/home');
                }
            }
        }
    }
}
