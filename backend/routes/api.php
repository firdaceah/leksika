<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\DocumentController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Routes Public (Tanpa Login)
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// Routes Protected (Harus Login)
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
<<<<<<< Updated upstream
    
=======

    Route::post('/documents', [DocumentController::class, 'store']);

>>>>>>> Stashed changes
    Route::get('/user', function (Request $request) {
        return $request->user();
    });
});
