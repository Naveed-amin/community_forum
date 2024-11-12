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
        $user = $this->whenLoaded('user') ?? '';
        return [
            'id' => $this->id,
            'content' => $this->content,
            'user_id' => $this->user_id,
            'user_name' => $user ? $this->user->name : null,
            'created_at' => $this->created_at->diffForHumans(),
        ];
    }
}
