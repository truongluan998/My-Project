<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UsersUpdateRequest extends FormRequest
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
            'email' => 'required|unique:users',
            'password' => 'bail|required|max:15|min:5',
            'address' => 'required'
        ];
    }

    public function messages()
    {
        return [
            'password.required' => 'Password cannot blank',
            'password.max' => 'Password max is 15 characters',
            'password.min' => 'Password min is 5 characters',
            'email.required' => 'Email cannot blank',
            'email.unique' => 'Email of user cannot same',
            'address.required' => 'Address cannot blank'
        ];
    }
}
