<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{
    protected $fillable = ['user_id', 'post_id', 'parent_id', 'content'];

    public function scopeWithAll($q)
    {
        $q->with('user')->with('post');
    }

    public function scopeWithChildrens($q)
    {
        $q->with('replies');
    }
    public function replies()
    {
        return $this->hasMany(Comment::class, 'parent_id', 'id');
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
