<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Share extends Model
{
    protected $fillable = [
        'user_id',
        'post_id',
        'comment',
    ];

    public function scopeWithAll($query)
    {
        return $query->with(['user', 'post']);
    }
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    public function post()
    {
        return $this->belongsTo(Post::class);
    }
}
