<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    use HasFactory;

    protected $table = 'posts';

    protected $fillable = ['user_id','parent_id', 'name', 'description','shared_content','shared_image', 'text', 'image'];

    public function scopeWithAll($query)
    {
        $query->with('user');
    }


    public function scopeWithChildrens($query)
    {
        $query->with(['likes','shares'])->with('comments',function($query){
            $query->withAll();
        });
    }
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function likes()
    {
        return $this->hasMany(Like::class);
    }
    public function shares()
    {
        return $this->belongsTo(Post::class,'parent_id','id');
    }

    public function comments(){
        return $this->hasMany(Comment::class);
    }

}
