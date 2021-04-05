<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Brand extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $table = "brand";
    protected $fillable = ['name'];

    public function product()
    {
        return $this->hasMany('App\Models\Product', 'brand_id', 'id');
    }

    public function brand()
    {
        return $this->belongsTo('App\Models\Categories', 'cate_id', 'id');
    }
}
