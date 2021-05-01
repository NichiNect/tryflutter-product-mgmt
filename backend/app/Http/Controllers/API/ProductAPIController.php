<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\ProductResource;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ProductAPIController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $products = Product::latest()->paginate(10);

        return ProductResource::collection($products);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'nama_product' => 'required',
            'description' => 'required',
            'price' => 'required',
        ]);

        if($request->hasFile('thumbnail')) {
            $file = $request->file('thumbnail');
            $extension = $file->extension();
            $fileName = date('Y-m-d', time()) . '-' . time() . $extension;
            $file->storeAs('/gambar/products/', $fileName, 'public');
        } else {
            $fileName = $request->thumbnail;
        }

        try{
            $product = Product::create([
                'nama_product' => $request->nama_product,
                'description' => $request->description,
                'thumbnail' => $fileName,
                'price' => $request->price,
            ]);
        } catch (\Illuminate\Database\QueryException $err) {
            return response($err);
        }

        return response()->json($product, 200);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        if($product = Product::findOrFail($id)) {
            return response($product);
        } else {
            return response([
                'error' => 'Product not found.'
            ],422);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'nama_product' => 'required',
            'description' => 'required',
            'price' => 'required',
        ]);
        
        if($product = Product::findOrFail($id)) {
            // check file
            if($request->hasFile('thumbnail')) {
                Storage::disk('public')->delete('/gambar/products/' . $product->thumbnail);
                $file = $request->file('thumbnail');
                $extension = $file->extension();
                $fileName = date('Y-m-d', time()) . '-' . time() . $extension;
                $file->storeAs('gambar/products/', $fileName, 'public');
            } else {
                $fileName = $request->thumbnail;
            }
            // update
            $product->update([
                'nama_product' => $request->nama_product,
                'description' => $request->description,
                'thumbnail' => $fileName,
                'price' => $request->price,
            ]);
        }

        return response()->json($product, 200);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        if($product = Product::findOrFail($id)) {
            Storage::disk('public')->delete('/gambar/products/' . $product->thumbnail);
            $product->delete();
            return response()->json([
                'success' => 'Deleted data successfully.'
            ], 200);
        } else {
            return response()->json([
                'error' => 'Product not found.'
            ], 404);
        }
    }
}
