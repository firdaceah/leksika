<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Summary extends Model
{
    protected $fillable = ['document_id', 'summary_text'];

    public function document()
    {
        return $this->belongsTo(Document::class);
    }
}
