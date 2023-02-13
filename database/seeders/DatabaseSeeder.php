<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // \App\Models\User::factory(10)->create();

        DB::table('users')->insertOrIgnore([[
            'name' => 'Alan',
            'email' => 'alan@example.com',
            'phone' => 88002000600,
        ], [
            'name' => 'Michael',
            'email' => 'michael@example.com',
            'phone' => 88005553535,
        ], [
            'name' => 'Derek',
            'email' => 'derek@example.com',
            'phone' => 88003445455,
        ]]);

        DB::table('payments')->insertOrIgnore([[
            'name' => 'Хлеб',
            'price' => 100,
            'user_id' => 1,
        ], [
            'name' => 'Мука',
            'price' => 200,
            'user_id' => 1,
        ], [
            'name' => 'Чипсы',
            'price' => 50,
            'user_id' => 2,
        ], [
            'name' => 'Вода',
            'price' => 80,
            'user_id' => 2,
        ]]);
    }
}
