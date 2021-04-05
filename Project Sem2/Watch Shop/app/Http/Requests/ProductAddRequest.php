<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ProductAddRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'name' => 'bail|required|unique:product|max:255|min:4',
            'price' => 'required',
            // 'category_id' => 'required',
            // 'brand_id' => 'required',
            'quantity' => 'required',
            'descriptions'  => 'required'
        ];
    }

    public function messages()
    {
        return [
            'name.required' => 'Name of product cannot blank',
            'name.unique' => 'Name of product cannot same',
            'name.max' => 'Name max is 255 characters',
            'name.min' => 'Name min is 4 characters',
            'price.required' => 'Price cannot blank',
            // 'category_id.required' => 'Category of product cannot blank',
            // 'brand_id.required' => 'Brand of product cannot blank',
            'quantity.required' => 'Quantity cannot blank',
            'descriptions.required' => 'Descriptions of product cannot blank'
        ];
    }
}
