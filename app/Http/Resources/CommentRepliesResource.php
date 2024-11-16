<?php

namespace App\Http\Resources;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CommentRepliesResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        // $user = $this->whenLoaded('user') ? $this->whenLoaded('user') : null;

        $user = User::findOrFail($this->user_id);

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
