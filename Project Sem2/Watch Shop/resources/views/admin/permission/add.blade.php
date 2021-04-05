@extends('admin.layout.admin')

@section('title')
<title>Add Permission</title>
@endsection

@section('css')
<link href="{{asset('vendor/select2/select2.min.css')}}" rel="stylesheet" />
<link href="{{asset('admins/user/add/add.css')}}" rel="stylesheet" />

@endsection

@section('content')
<div class="content-wrapper">
    <div class="content-header">
        @include('admin.partials.content-header', ['name' => 'Permission', 'key' => 'Add'])
    </div>
    <div class="container">
        <form action="{{ route('permissions.store')}}" method="POST" enctype="multipart/form-data">
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md">
                            @csrf
                            <div class="row">
                                <div class="col-md-12">

                                    <div class="form-group">
                                        <label>Authorizations:</label>
                                        <select name="module_parent" class="form-control" >
                                            {{-- class="form-control select2_init" --}}
                                            <option value="">Name Authorization</option>
                                            @foreach (config('permissions.table_module') as $moduleItem)
                                            <option value="{{$moduleItem}}">{{$moduleItem}}</option>
                                            @endforeach
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <div class="row">
                                            @foreach (config('permissions.module_childrent') as $moduleItemChildrent)
                                            <div class="col-md-3">
                                                <label for="">
                                                    <input type="checkbox" name="module_childrent[]" value="{{ $moduleItemChildrent }}">
                                                    {{ $moduleItemChildrent }}
                                                </label>
                                            </div>
                                            @endforeach
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-primary float-right"
                                        style="margin-bottom: 20px;">Submit</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

@endsection

@section('js')
<script src="{{asset('vendor/select2/select2.min.js')}}"></script>
<script src="{{asset('admins/user/add/add.js')}}"></script>


@endsection
