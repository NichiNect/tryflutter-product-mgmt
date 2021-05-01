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
            'description' => 'Processor intel i5 generasi ke 9 dengan performa yang sangat joss',
            'thumbnail' => '',
            'price' => 2500000,
        ]);

        Product::create([
            'nama_product' => 'Processor Intel Core i5 10500K',
            'description' => 'Processor intel i5 generasi ke 10 dengan performa yang joss dan dapat dipakai untuk gaming maupun editing',
            'thumbnail' => '',
            'price' => 2700000,
        ]);

        Product::create([
            'nama_product' => 'RAM V-Gen Platinum DDR4 2100MHz 8GB',
            'description' => 'RAM DDR4 2100MHz 8GB merk V-Gen Platinum. Lifetime Warranty',
            'thumbnail' => '',
            'price' => 400000,
        ]);

        Product::create([
            'nama_product' => 'RAM V-Gen Platinum DDR3 1333MHz 4GB',
            'description' => 'RAM DDR4 2100MHz 4GB merk V-Gen Platinum. Lifetime Warranty',
            'thumbnail' => '',
            'price' => 200000,
        ]);

        Product::create([
            'nama_product' => 'Processor Intel Core i5 5500K',
            'description' => 'Processor intel i5 generasi ke 5 dengan performa yang cukup untuk developer',
            'thumbnail' => '',
            'price' => 1300000,
        ]);
    }
}
