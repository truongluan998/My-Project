@extends('layout')
@section('content')
<div class="container">
    <h2>Search Results: </h2>
    @foreach ($products as $item)
    <div class="search-item">
        <a href="detail/{{$item['id']}}">
            <img class="search-image" src="{{$item['feature_image']}}" style="height: 130px; width: 130px">
            <div class="">
                <h3>{{$item['name']}}</h3>
                <h5>{{$item['content']}}</h5>
            </div>
        </a>
    </div>
    @endforeach
</div>
@endsection
