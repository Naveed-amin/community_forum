<?php

namespace Database\Seeders;

use App\Models\Post;
use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;


class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {

        User::factory()->create([
            'name' => 'Naveed Amin',
            'email' => 'naveedmughal1182@gmail.com',
            'password' => bcrypt('12345678'),
            'remember_token' => Str::random(10),
        ]);
        User::factory(10)->create();
        Post::factory(10)->create();
    //    $this->call(PostSeeder::class);


    }
}