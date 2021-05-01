<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model as Model;



/**
 * Class Product
 * @package App\Models
 * @version May 1, 2021, 1:40 am UTC
 *
 * @property 'description' $['nama_product',
 */
class Product extends Model
{


    public $table = 'products';


    public $fillable = [
        'nama_product', 'description', 'thumbnail', 'price'
    ];

    /**
     * The attributes that should be casted to native types.
     *
     * @var array
     */
    protected $casts = [
        'id' => 'integer'
    ];

    /**
     * Validation rules
     *
     * @var array
     */
    public static $rules = [
        'nama_product' => 'required', 
        'description' => 'required', 
        'price' => 'required|numeric'
    ];

    
}
