<script setup>

import {onMounted, ref} from "vue";

const users = ref([])

const loadUsers = async () => await axios.get('api/users').then(response => {
    users.value = response.data.data
})

onMounted(() => loadUsers())

const deleteUser = (id) => {
    if (!confirm('Are you sure?')) return

    axios.delete(`api/users/${id}`).finally(() => loadUsers())
}

const editUser = (id) => {
    location.href=`/users/${id}/edit`
}

defineProps({
    authUser: Object,
});
</script>

<template>
    <nav class="relative w-full flex flex-wrap items-center justify-between py-3 bg-gray-100 text-gray-500 hover:text-gray-700 focus:text-gray-700 shadow-lg">
        <div class="container-fluid w-full flex flex-wrap items-center justify-between px-6">
            <div class="container-fluid">
                <a class="text-xl text-black font-semibold" href="/users">Users</a>
            </div>
            <div v-if="authUser">
                <a href="/logout">Logout</a>
            </div>
            <div v-else class="flex items-center relative">
                <a class="mr-2" href="/register">Register</a>
                <a href="/login">Login</a>
            </div>
        </div>
    </nav>
    <div class="flex flex-col">
        <div class="overflow-x-auto sm:-mx-6 lg:-mx-8">
            <div class="py-2 inline-block min-w-full sm:px-6 lg:px-8">
                <div class="overflow-hidden">
                    <table class="min-w-full">
                        <thead class="border-b">
                            <tr>
                                <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                                    Имя
                                </th>
                                <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                                    Email
                                </th>
                                <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                                    Телефон
                                </th>
                                <th v-if="authUser" scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="user in users" class="bg-white border-b transition duration-300 ease-in-out hover:bg-gray-100">
                                <td class="text-sm text-blue-900 font-bold px-6 py-4 whitespace-nowrap">
                                    <a :href="`/users/${user.id}/payments`">{{ user.name }}</a>
                                </td>
                                <td class="text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap">
                                    {{ user.email }}
                                </td>
                                <td class="text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap">
                                    {{ user.phone }}
                                </td>
                                <td v-if="authUser" class="text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap">
                                    <button @click="editUser(user.id)" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mr-2">
                                        Edit
                                    </button>
                                    <button @click="deleteUser(user.id)" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">
                                        Delete
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</template>
