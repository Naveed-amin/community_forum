<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PostsResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $user = $this->whenLoaded('user') ? $this->whenLoaded('user') : null;
        $likes = $this->whenLoaded('likes') ? $this->whenLoaded('likes') : null;
        $shares = $this->whenLoaded('shares') ? $this->whenLoaded('shares') : null;
        $comments = $this->whenLoaded('comments') ? $this->whenLoaded('comments') : null;

        return [
            'id' =>  $this->id,
            'user_id' => $this->user_id,
            'user_name' => $user ?  $user->name : null,
            'name' => $this->name,
            'description' => $this->description,
            'title' => $this->title,
            'image' => $this->image,
            'shared_content' => $this->shared_content,
            'likes_count' => $likes ? $likes->count() : 0,
            'comments' => $comments ? CommentsResource::collection($comments) : '',
            'shares_count' => $shares ? $shares->whereNotNull('parent_id')->count() : 0,
            'created_at' => $this->created_at,
        ];
    }
}
