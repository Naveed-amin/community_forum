<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('posts', function (Blueprint $table) {
            $table->integer('parent_id')->nullable()->after('id');
            $table->text('shared_content')->nullable()->after('image');
            $table->string('shared_image')->nullable()->after('shared_content');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('posts', function (Blueprint $table) {
            $table->dropColumn('parent_id');
            $table->dropColumn('shared_content');
            $table->dropColumn('shared_image');
        });
    }
};
