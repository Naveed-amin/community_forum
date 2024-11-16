<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CommentsResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $user = $this->whenLoaded('user') ? $this->whenLoaded('user') : null;

        // dd($user);
        return [
            'id' => $this->id,
            'parent_id' => $this->parent_id,
            'replies' => $this->replies,
            'content' => $this->content,
            'user_id' => $this->user_id,
            'user_name' => $user ? $user->name : null,
            'created_at' => $this->created_at->diffForHumans(),
        ];
    }
}
