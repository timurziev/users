<script setup>

import {onMounted, ref} from "vue";

const payments = ref([])

const loadPayments = async () => await axios.get(`/api/users/${window.location.pathname.split('/')[2]}/payments`).then(response => {
    payments.value = response.data.data
})

onMounted(() => loadPayments())

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
                                Название
                            </th>
                            <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                                Цена
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="payment in payments" class="bg-white border-b transition duration-300 ease-in-out hover:bg-gray-100">
                            <td class="text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap">
                                {{ payment.name }}
                            </td>
                            <td class="text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap">
                                {{ payment.price }}
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</template>
