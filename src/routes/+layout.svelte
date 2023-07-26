<script>
	import '../app.postcss';
	import Footer from '$lib/components/Footer.svelte';
</script>

<div class="w-full h-screen bg-black">
	<slot />
	<Footer />
</div>
