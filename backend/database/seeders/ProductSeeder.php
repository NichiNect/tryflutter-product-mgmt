<?php

namespace Database\Seeders;

use App\Models\Product;
use Illuminate\Database\Seeder;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Product::create([
            'nama_product' => 'Processor Intel Core i9 9900K',
            'description' => 'Processor intel i5 generasi ke 9',
            'thumbnail' => '',
            'price' => 2500000,
        ]);

        Product::create([
            'nama_product' => 'Processor Intel Core i5 10500K',
            'description' => 'Processor intel i5 generasi ke 10',
            'thumbnail' => '',
            'price' => 2700000,
        ]);

        Product::create([
            'nama_product' => 'RAM V-Gen Platinum DDR4 2100MHz 8GB',
            'description' => 'RAM DDR4 2100MHz',
            'thumbnail' => '',
            'price' => 400000,
        ]);
    }
}
