<?php

namespace App\Providers;

use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Gate;
use App\Policies\CategoryPolicy;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The policy mappings for the application.
     *
     * @var array
     */
    protected $policies = [
        // 'App\Models\Model' => 'App\Policies\ModelPolicy',
    ];

    /**
     * Register any authentication / authorization services.
     *
     * @return void
     */
    public function boot()
    {
        $this->registerPolicies();
        $this->defineGateCategory();
        $this->defineGateBrand();
        $this->defineGateUser();
        $this->defineGateProduct();
        $this->defineGateRole();
        $this->defineGatePermission();
        $this->defineGateOrder();
    }

    public function defineGateCategory()
    {
        Gate::define('category-list', 'App\Policies\CategoryPolicy@view');
        Gate::define('category-add', 'App\Policies\CategoryPolicy@create');
        Gate::define('category-edit', 'App\Policies\CategoryPolicy@update');
        Gate::define('category-delete', 'App\Policies\CategoryPolicy@delete');
    }

    public function defineGateBrand()
    {
        Gate::define('brand-list', 'App\Policies\BrandPolicy@view');
        Gate::define('brand-add', 'App\Policies\BrandPolicy@create');
        Gate::define('brand-edit', 'App\Policies\BrandPolicy@update');
        Gate::define('brand-delete', 'App\Policies\BrandPolicy@delete');
    }

    public function defineGateUser()
    {
        Gate::define('admin-home', 'App\Policies\UserPolicy@homeadmin');
        Gate::define('user-list', 'App\Policies\UserPolicy@view');
        Gate::define('user-add', 'App\Policies\UserPolicy@create');
        Gate::define('user-edit', 'App\Policies\UserPolicy@update');
        Gate::define('user-delete', 'App\Policies\UserPolicy@delete');
    }

    public function defineGateProduct()
    {
        Gate::define('product-list', 'App\Policies\ProductPolicy@view');
        Gate::define('product-add', 'App\Policies\ProductPolicy@create');
        Gate::define('product-edit', 'App\Policies\ProductPolicy@update');
        Gate::define('product-delete', 'App\Policies\ProductPolicy@delete');
    }

    public function defineGateRole()
    {
        Gate::define('role-list', 'App\Policies\RolePolicy@view');
        Gate::define('role-add', 'App\Policies\RolePolicy@create');
        Gate::define('role-edit', 'App\Policies\RolePolicy@update');
        Gate::define('role-delete', 'App\Policies\RolePolicy@delete');
    }

    public function defineGateOrder()
    {
        Gate::define('order-list', 'App\Policies\OrderPolicy@view');
        Gate::define('order-edit', 'App\Policies\OrderPolicy@update');
    }

    public function defineGatePermission()
    {
        Gate::define('permission-list', 'App\Policies\PermissionPolicy@view');
    }
}
