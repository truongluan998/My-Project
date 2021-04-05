<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Categories extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $table = "categories";
    protected $fillable = ['name'];


    public function product()
    {
        return $this->hasMany('App\Models\Product', 'category_id', 'id');
    }
    public function brand()
    {
        return $this->hasMany('App\Models\Brand', 'brand_id', 'id');
    }
}
