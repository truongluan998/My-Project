<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class BrandsAddRequest extends FormRequest
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
            'name' => 'bail|required|unique:brand'
        ];
    }

    public function messages()
    {
        return [
            'name.required' => 'Name of brand cannot blank',
            'name.unique' => 'Name of brand cannot same',
        ];
    }
}
