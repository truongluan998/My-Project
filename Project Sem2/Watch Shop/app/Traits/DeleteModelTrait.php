<?php

namespace App\Traits;

use Illuminate\Support\Facades\Log;

trait DeleteModelTrait
{
    public function deleteModelTrait($id, $model)
    {
        try {
            $model->find($id)->delete();
            // echo '<pre>';
            // print_r($this->product->find($id));
            return response()->json([
                'code' => 200,
                'message' => 'success'
            ], 200);
        } catch (Exception $ex) {
            Log::error('Message: ' . $ex->getMessage() . 'Line: ' . $ex->getLine());
            return response()->json([
                'code' => 500,
                'message' => 'fail'
            ], 500);
        }
    }
}
