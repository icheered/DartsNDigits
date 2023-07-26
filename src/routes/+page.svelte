<script lang="ts">
	import 'iconify-icon';

	let roundCounter = 0;
	let teamNumberCounter = 0;
	let teams = [];

	let dartsPerRound = 3;

	// Sort teams by score
	let newTeamName = '';

	async function addTeam() {
		teamNumberCounter += 1;
		const newTeam = {
			name: newTeamName,
			score: 0,
			thrownDarts: 0,
			id: teamNumberCounter
		};

		teams = [...teams, newTeam]; // create a new array and assign it to teams
		newTeamName = '';
	}

	async function deleteTeam(teamId) {
		teams = teams.filter((team) => team.id !== teamId);
	}

	async function updateScore(teamId, amount) {
		// Update the score of the team
		teams = teams.map((team) => {
			if (team.id === teamId) {
				team.score += amount;
			}
			return team;
		});
	}

	async function nextRound() {
		roundCounter += 1;
	}

	async function reset() {
		roundCounter = 0;
		teamNumberCounter = 0;
		teams = [];
	}

	function displayScore(score) {
		if (score == 21) {
			return 'GREEN';
		} else if (score == 22) {
			return 'RED';
		} else if (score == 23) {
			return 'WIN';
		} else {
			return score;
		}
	}
</script>

<div class="w-full flex justify-center p-4 bg-black pb-12">
	<div class="card bg-base-100 shadow-xl h-min">
		<div class="card-body flex flex-col place-items-center">
			<h1
				class="font-bold leading-tight tracking-tight text-4xl text-center text-black dark:text-white"
			>
				Darts 'n Digits
			</h1>

			<div class="grid grid-cols-12 font-semibold w-full text-center">
				<div class="col-span-2 h-full flex justify-center place-items-center">
					<button class="btn text-gray-400" on:click={() => (dartsPerRound -= 1)}>-1</button>
				</div>

				<div class="col-span-4 flex flex-col text-gray-400">
					<div class="font-semibold">Darts Per Round</div>
					<div class="col-span-1 flex justify-center place-items-center text-4xl">
						{dartsPerRound}
					</div>
				</div>

				<div class="col-span-2 flex justify-center place-items-center">
					<button class="btn text-gray-400" on:click={() => (dartsPerRound += 1)}>+1</button>
				</div>
				<div class="w-full col-span-4 flex justify-center place-items-center">
					<button class="btn text-gray-400" on:click={() => reset()} on:keydown={() => reset()}
						>Reset</button
					>
				</div>
			</div>

			<div class="flex flex-col">
				<div class="flex flex-row gap-x-2">
					<input
						type="text"
						placeholder="Team name"
						bind:value={newTeamName}
						class="input input-bordered w-full max-w-xs"
					/>
					<button class="btn bg-primary-light text-white" on:click={addTeam}>Add</button>
				</div>
			</div>

			<div class="grid grid-cols-12 font-semibold w-full text-center">
				{#each teams as team, index}
					<div class="col-span-2 h-full flex justify-center place-items-center">
						<button
							class="btn bg-primary-light text-white"
							on:click={() => updateScore(team.id, -1)}>-1</button
						>
					</div>

					<div class="col-span-6 flex flex-col">
						<div class="font-semibold text-xl">
							{team.name.toUpperCase()}
						</div>
						<div class="col-span-1 flex justify-center place-items-center text-4xl">
							{displayScore(team.score)}
						</div>
					</div>

					<div class="col-span-2 flex justify-center place-items-center">
						<button class="btn bg-primary-light text-white" on:click={() => updateScore(team.id, 1)}
							>+1</button
						>
					</div>
					<div class="col-span-1 flex justify-center place-items-center">
						<button class="ml-8" on:click={() => deleteTeam(team.id)}
							><iconify-icon class="text-neutral" icon="mdi:trash" width="36" height="36" />
						</button>
					</div>
				{/each}
			</div>

			<div class="w-full text-center text-3xl font-bold pt-8">SCORE</div>

			<div class="text-5xl font-bold text-center">
				{roundCounter * dartsPerRound}
			</div>

			<button
				class="w-full h-48 text-white btn bg-primary-light"
				on:click={() => nextRound()}
				on:keydown={() => nextRound()}
			>
				Next round
			</button>
		</div>
	</div>
</div>
