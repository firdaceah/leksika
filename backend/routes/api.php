<?php

use App\Http\Controllers\Api\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Routes Public (Tanpa Login)
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// Routes OTP (Butuh Login, Belum Perlu Verified)
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/email/verify-otp', [AuthController::class, 'verifyOtp']);
    Route::post('/email/resend-otp', [AuthController::class, 'resendOtp']);
});

// Routes Protected (Harus Login + Verified)
Route::middleware(['auth:sanctum', 'verified'])->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);

    Route::get('/user', function (Request $request) {
        return $request->user();
    });
});