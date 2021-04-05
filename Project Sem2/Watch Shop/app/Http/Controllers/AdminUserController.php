<?php

namespace App\Http\Controllers;

use App\Http\Requests\UsersAddRequest;
use App\Http\Requests\UsersUpdateRequest;
use App\Models\Role;
use Illuminate\Http\Request;

use App\Models\User;
use App\Traits\DeleteModelTrait;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;

class AdminUserController extends Controller
{

    use DeleteModelTrait;
    private $user;

    public function __construct(User $user, Role $role)
    {
        $this->user = $user;
        $this->role = $role;
    }

    public function index()
    {
        $users = $this->user->paginate(5);

        return \view('admin.user.index', \compact('users'));
    }

    public function create()
    {
        $roles = $this->role->all();
        return \view('admin.user.add', \compact('roles'));
    }

    public function store(UsersAddRequest $request)
    {
        try {
            DB::beginTransaction();

            $dataUsersCreate = [
                'username' => $request->username,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'address' => $request->address
            ];
            $user = $this->user->create($dataUsersCreate);

            $user->roles()->attach($request->role_id);
            DB::commit();
            return \redirect()->route('users.index');
        } catch (\Exception $ex) {
            DB::rollback();
            Log::error('Message: ' . $ex->getMessage() . '---- Line: ' . $ex->getLine());
        }
    }

    public function edit($id)
    {
        $roles = $this->role->all();
        $user = $this->user->find($id);
        $rolesOfUser = $user->roles;
        return \view('admin.user.edit', \compact('roles', 'user', 'rolesOfUser'));
    }

    public function update(UsersUpdateRequest $request, $id)
    {

        try {
            DB::beginTransaction();

            $user = User::find($id);

            if ($user->email == $request->email) {
                $this->user->find($id)->update([
                    'password' => Hash::make($request->password),
                    'address' => $request->address
                ]);
            } else {
                $this->user->find($id)->update([
                    'email' => $request->email,
                    'password' => Hash::make($request->password),
                    'address' => $request->address
                ]);
            }

            $user = $this->user->find($id);
            $user->roles()->sync($request->role_id);
            DB::commit();
            return \redirect()->route('users.index');
        } catch (\Exception $ex) {
            DB::rollback();
            Log::error('Message: ' . $ex->getMessage() . '---- Line: ' . $ex->getLine());
        }
    }

    public function delete($id)
    {
        return $this->deleteModelTrait($id, $this->user);
    }
}
