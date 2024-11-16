<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, useForm } from '@inertiajs/vue3';
import axios from 'axios';
import { ref, onMounted, reactive } from 'vue';

const openModal = ref(false);
const openShareModal = ref(false);
const selectedPost = ref(null);
const comment_input = reactive([]);
const newComment = ref('');
const shareComment = ref('');

const props = defineProps({
    posts: {
        type: Array,
        required: true,
    }
});

const form = useForm({
    name: null,
    image: null,
});

function submitPost() {
    form.post(route('posts.store'), {
        onSuccess: () => handleCloseModal(),
    });
}

onMounted(() => {
    props.posts.forEach(() => {
        comment_input.push(false);
    });
});

const toggleCommentBox = (index) => {
    comment_input[index] = !comment_input[index];
};

const addComment = (post) => {
    if (!newComment.value.trim()) return console.error('Comment cannot be empty');
    axios.post(route('post.comment', post.id), { comment: newComment.value })
        .then(response => {
            newComment.value = '';
            if (response.data.comment) post.comments.push(response.data.comment);
        })
        .catch(error => {
            console.error('Error adding comment to the post:', error);
        });
};

const handleShare = () => {
    axios.post(route('post.share', selectedPost.value), { comment: shareComment.value })
        .then(() => handleShareCloseModal())
        .catch(error => {
            console.error('Error sharing the post:', error);
        });
};

const handleLike = (post) => {
    axios.get(route('post.like.unlike', post.id))
        .then(response => {
            post.likes_count = response.data.likes;
        })
        .catch(error => {
            console.error("Error liking/unliking the post:", error);
        });
};

const handleNewPostInputClick = () => {
    openModal.value = true;
};

const handleSharePostInputClick = (post) => {
    selectedPost.value = post;
    openShareModal.value = true;
};

const handleCloseModal = () => {
    openModal.value = false;
};

const handleShareCloseModal = () => {
    openShareModal.value = false;
    shareComment.value = '';
    selectedPost.value = null;
};
</script>

<template>
    <Head title="Social Media" />
    <AuthenticatedLayout>
        <!-- New Post Input -->
        <template #header>
            <input
                type="text"
                @click="handleNewPostInputClick"
                placeholder="Create New Post..."
                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5"
                readonly
            >
        </template>

        <!-- Posts Section -->
        <div class="py-12 flex justify-center">
            <div class="max-w-3xl w-full">
                <div class="bg-white shadow-sm rounded-lg p-6">
                    <div v-for="(post, index) in posts" :key="post.id" class="border rounded-lg p-4 mb-6">
                        <!-- Shared Content -->
                        <h2
                            v-if="post.shared_content"
                            class="text-center text-gray-700 font-medium mb-4">
                            {{ post.shared_content }}
                        </h2>
                        <hr>

                        <!-- Post Name -->
                        <h3 class="text-center text-gray-700 font-medium mb-4">{{ post.name }}</h3>

                        <!-- Post Image -->
                        <div class="flex justify-center mb-4">
                            <img
                                :src="`/storage/${post.image}`"
                                alt="Post Image"
                                class="w-full max-w-md rounded-md shadow-md"
                            >
                        </div>

                        <!-- Action Buttons: Like, Comment, Share -->
                        <div class="flex justify-center space-x-6 mt-4">
                            <button
                                @click="handleLike(post)"
                                class="text-blue-500 hover:text-blue-700 font-semibold">
                                Like ({{ post.likes_count }})
                            </button>
                            <button
                                @click="toggleCommentBox(index)"
                                class="text-green-500 hover:text-green-700 font-semibold">
                                Comment
                            </button>
                            <button
                                @click="handleSharePostInputClick(post)"
                                class="text-purple-500 hover:text-purple-700 font-semibold">
                                Share ({{ post.shares_count }})
                            </button>
                        </div>

                        <!-- Comments Section -->
                       <div class="mt-6">
    <h4 class="text-gray-700 font-bold text-lg mb-4 border-b pb-2 border-gray-200">
        Comments
    </h4>

    <div v-if="post.comments && post.comments.length > 0" class="space-y-6">
        <!-- Main comment -->
        <div
            v-for="comment in post.comments"
            :key="comment.id"
            class="border border-gray-200 rounded-lg p-4 shadow-sm bg-white"
        >
            <div class="flex items-center gap-3 mb-2">
                <div class="w-10 h-10 rounded-full bg-gray-300 flex items-center justify-center text-white text-lg">
                    {{ comment.user_name.charAt(0).toUpperCase() }}
                </div>
                <div>
                    <p class="text-gray-900 font-medium">{{ comment.user_name }}</p>
                    <span class="text-gray-400 text-sm">{{ comment.created_at }}</span>
                </div>
            </div>
            <p class="text-gray-700 leading-relaxed">{{ comment.content }}</p>

            <!-- Replies -->
            <div v-if="comment.replies && comment.replies.length > 0" class="mt-4 pl-6 border-l-2 border-gray-200">
                <h5 class="text-gray-600 text-sm font-semibold mb-2">Replies:</h5>
                <div
                    v-for="reply in comment.replies"
                    :key="reply.id"
                    class="border border-gray-100 rounded-lg p-3 bg-gray-50"
                >
                    <div class="flex items-center gap-3 mb-2">
                        <div class="w-8 h-8 rounded-full bg-gray-300 flex items-center justify-center text-white text-sm">
                            {{ reply.user_name }}
                        </div>
                        <div>
                            <p class="text-gray-800 font-medium">{{ reply.user_name }}</p>
                            <span class="text-gray-400 text-xs">{{ reply.created_at }}</span>
                        </div>
                    </div>
                    <p class="text-gray-600 leading-relaxed">{{ reply.content }}</p>
                </div>
            </div>
        </div>
    </div>

    <p v-else class="text-gray-500 text-sm text-center mt-4">
        No comments yet. Be the first to comment!
    </p>
</div>


                        <!-- Comment Input -->
                        <input
                            v-if="comment_input[index]"
                            type="text"
                            v-model="newComment"
                            @keyup.enter="addComment(post)"
                            placeholder="Comment..."
                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 mt-2"
                        >
                    </div>
                </div>
            </div>
        </div>

        <!-- New Post Modal -->
        <div
            v-if="openModal"
            class="fixed inset-0 z-50 flex items-center justify-center bg-gray-800 bg-opacity-50"
        >
            <div class="bg-white rounded-lg shadow-lg w-full max-w-md p-6">
                <h3 class="text-lg font-semibold mb-4">Create New Post</h3>
                <form @submit.prevent="submitPost">
                    <input
                        v-model="form.name"
                        type="text"
                        placeholder="Post Title"
                        class="w-full mb-4 border rounded-lg p-2"
                    >
                    <input
                        type="file"
                        @change="e => form.image = e.target.files[0]"
                        class="w-full mb-4 border rounded-lg p-2"
                    >
                    <button
                        type="submit"
                        class="bg-blue-500 text-white px-4 py-2 rounded-lg">
                        Submit
                    </button>
                    <button
                        @click="handleCloseModal"
                        type="button"
                        class="ml-2 bg-gray-300 text-black px-4 py-2 rounded-lg">
                        Cancel
                    </button>
                </form>
            </div>
        </div>

        <!-- Share Post Modal -->
        <div
            v-if="openShareModal"
            class="fixed inset-0 z-50 flex items-center justify-center bg-gray-800 bg-opacity-50"
        >
            <div class="bg-white rounded-lg shadow-lg w-full max-w-md p-6">
                <h3 class="text-lg font-semibold mb-4">Share Post</h3>
                <textarea
                    v-model="shareComment"
                    rows="4"
                    class="w-full mb-4 border rounded-lg p-2"
                    placeholder="Add a comment..."
                ></textarea>
                <div class="flex justify-end">
                    <button
                        @click="handleShare"
                        class="bg-purple-500 text-white px-4 py-2 rounded-lg">
                        Share
                    </button>
                    <button
                        @click="handleShareCloseModal"
                        type="button"
                        class="ml-2 bg-gray-300 text-black px-4 py-2 rounded-lg">
                        Cancel
                    </button>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

