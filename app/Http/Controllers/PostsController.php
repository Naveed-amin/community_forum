<?php

namespace App\Http\Controllers;

use App\Http\Resources\CommentsResource;
use App\Http\Resources\PostsResource;
use App\Models\Post;
use App\Models\Share;
use Illuminate\Http\Request;
use Inertia\Inertia;

class PostsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $posts = Post::withAll()->withChildrens()->latest()->get();
        // dd($posts);
        $posts = PostsResource::collection($posts);
        return Inertia::render('Dashboard', [
            'posts' => $posts,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $imagePath = null;


        $request->merge(['user_id' => auth()->id()]);

        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imagePath = $image->store('images', 'public');
        }

        $post = Post::create($request->all());
        $post->image = $imagePath;
        $post->save();

        $post = Post::find($post->id);
        $post = new PostsResource($post);

        return redirect()->route('posts.store')->with('success', 'Post created successfully')->with('post', $post);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }


    public function likeUnlike(Request $request, Post $post)
    {
        $existingLike = $post->likes()->where('user_id', auth()->id())->first();

        if ($existingLike) {
            $existingLike->delete();
        } else {
            $post->likes()->create([
                'user_id' => auth()->id(),
            ]);
        }
        return response()->json(['likes' => $post->likes()->count()]);
    }

    public function sharePost(Request $request, Post $post)
    {
        // dd($request->all());
        $share = Post::create([
            'parent_id' => $post->id,
            'name' => $post->name,
            'shared_content' => $request->comment,
            'user_id' => auth()->id(),
            'image' => $post->image,
        ]);

        return redirect()->route('posts.store')->with('success', 'Post share successfully');
    }
    public function commentPost(Request $request, Post $post)
    {
        $comment = $post->comments()->create([
            'user_id' => auth()->id(),
            'content' => $request->comment,
        ]);
        $comment = $comment->withAll()->withChildrens()->find($comment->id);

        $comment = new CommentsResource($comment);
        return response()->json(['comment' => $comment]);
    }
}
