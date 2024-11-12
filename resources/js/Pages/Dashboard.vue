<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, router, useForm } from '@inertiajs/vue3';
import axios from 'axios';
import { ref, onMounted, reactive } from 'vue';

const openModal = ref(false);
const openShareModal = ref(false);

const selectedPost = ref(null);
const comment_input = reactive([]);
const newComment = ref('');


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
    form.post(route('posts.store'), form, {
        onSuccess: handleCloseModal()
    });
}

// onMounted(() => {

//     props.posts.forEach(() => {
//         comment_input.push(false);
//     });
// });

const toggleCommentBox = (index) => {
    comment_input[index] = !comment_input[index];
};

const addComment = (post) => {
    axios.post(route('post.comment', post.id), {
        comment: newComment.value,
    })
        .then(response => {
            newComment.value = '';
            if (response.data.comment) {
                post.comments.push(response.data.comment);
            }
        })
        .catch(error => {
            console.error('Error adding comment to the post:', error);
        });
};


const handleShare = () => {
    axios.post(route('post.share', selectedPost.value), {
        comment: comment.value,
    })
        .then(response => {
            handleShareCloseModal();
            console.log('Post shared successfully:', response.data);
        })
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
    comment.value = '';
    selectedPost.value = null;
};
</script>

<template>

    <Head title="Social Media" />
    <AuthenticatedLayout>
        <template #header>
            <input type="text" @click="handleNewPostInputClick" placeholder="Create New Post..."
                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5"
                readonly>
        </template>

        <div class="py-12 flex justify-center">
            <div class="max-w-3xl w-full">
                <div class="bg-white shadow-sm rounded-lg p-6">
                    <div v-for="(post, index) in posts" :key="post.id" class="border rounded-lg p-4 mb-6">
                        <h2 class="text-center text-gray-700 font-medium mb-4" v-if="post.shared_content">{{
                            post.shared_content
                            }}</h2>
                        <hr>

                        <h3 class="text-center text-gray-700 font-medium mb-4">{{ post.name }}</h3>
                        <!-- Post Image -->
                        <div class="flex justify-center mb-4">
                            <img :src="`/storage/${post.image}`" alt="Post Image"
                                class="w-full max-w-md rounded-md shadow-md">
                        </div>

                        <!-- Action Buttons: Like, Comment, Share -->
                        <div class="flex justify-center space-x-6 mt-4">
                            <button @click="handleLike(post)" class="text-blue-500 hover:text-blue-700 font-semibold">
                                Like ({{ post.likes_count }})
                            </button>
                            <button @click="toggleCommentBox(index)"
                                class="text-green-500 hover:text-green-700 font-semibold">
                                Comment
                            </button>
                            <button @click="handleSharePostInputClick(post)"
                                class="text-purple-500 hover:text-purple-700 font-semibold">
                                Share ({{ post.shares_count }})
                            </button>
                        </div>

                        <div class="mt-6">
                            <h4 class="text-gray-600 font-semibold mb-3">Comments:</h4>
                            <div v-if="post.comments && post.comments.length > 0" class="space-y-4">
                                <div v-for="comment in post.comments" :key="comment.id"
                                    class="border border-gray-300 rounded-lg p-3 bg-gray-50">
                                    <p class="text-gray-800 font-semibold">{{ post.user_name }}</p>
                                    <p class="text-gray-600">{{ comment.content }}</p>
                                    <span class="text-gray-400 text-xs">{{ comment.created_at }}</span>
                                </div>
                            </div>
                            <p v-else class="text-gray-500 text-sm">No comments yet. Be the first to comment!</p>
                        </div>

                        <!-- Comment Input -->
                        <input v-if="comment_input[index]" type="text" v-model="newComment"
                            @keyup.enter="addComment(post)" placeholder="Comment..."
                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 mt-2">
                    </div>
                </div>
            </div>
        </div>

        <!-- New Post Modal -->
        <div v-if="openModal" class="fixed inset-0 z-50 flex items-center justify-center bg-gray-800 bg-opacity-50">
            <div class="bg-white rounded-lg shadow-lg w-full max-w-md">
                <!-- Modal Content Here -->
            </div>
        </div>

        <!-- Share Post Modal -->
        <div v-if="openShareModal"
            class="fixed inset-0 z-50 flex items-center justify-center bg-gray-800 bg-opacity-50">
            <div class="bg-white rounded-lg shadow-lg w-full max-w-md">
                <!-- Share Modal Content Here -->
            </div>
        </div>
    </AuthenticatedLayout>
</template>
