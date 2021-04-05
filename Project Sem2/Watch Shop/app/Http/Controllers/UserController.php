<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Role;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Auth;

use App\Traits\DeleteModelTrait;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;

class UserController extends Controller
{
    use DeleteModelTrait;
    private $user;

    public function __construct(User $user, Role $role)
    {
        $this->user = $user;
        $this->role = $role;
    }
    public function register()
    {
        return view('pages.register');
    }
    public function saveUser(Request $request)
    {
        try {
            DB::beginTransaction();
            $data = $request->all();
            $user = new User();
            $user->username = $data['user'];
            $user->email = $data['email'];
            $user->password = Hash::make($data['password']);
            $user->address = $data['address'];
            $user->save();
            // dd($userdata,$user);
            //$user->roles()->attach($request->role_id);
            DB::commit();
            return Redirect::to('/register');
        } catch (\Exception $ex) {
            DB::rollback();
            Log::error('Message: ' . $ex->getMessage() . '---- Line: ' . $ex->getLine());
        }
    }

    public function getLogin()
    {
        return view('/pages.userlogin');
    }

    public function postLogin(Request $request)
    {
        $arr = [
            'username' => $request->username,
            'password' => $request->password
        ];

        if (Auth::attempt($arr)) {
            return Redirect::to('/home');
        } else {
            \dd("Login fail!!");
        }
    }
}
