// This is the main file for the frontend application

// Required Dependencies
const dotenv = require('dotenv');
const fs = require('fs');

// Load env vars
dotenv.config();
const DISCORD_TOKEN = process.env.DISCORD_TOKEN;

// Require the necessary discord.js classes
const { Client, Intents, Collection } = require('discord.js');

// Create a new client instance
const client = new Client({ intents: [Intents.FLAGS.GUILDS] });

// Load all commands from the commands folder
const commandFiles = fs.readdirSync('./commands').filter(file => file.endsWith('.js'));

// Creating a collection for commands in client
const commands = [];
client.commands = new Collection();
for (const file of commandFiles) {
    const command = require(`./commands/${file}`);
    commands.push(command.data.toJSON());
    client.commands.set(command.data.name, command);
}

// When the client is ready, run this code (only once)
client.once('ready', () => {
	console.log('Ready!');
});

// Login to Discord
client.login(DISCORD_TOKEN);

// Main
client.on('interactionCreate', async interaction => {

    console.log("Processing command:", interaction.commandName);
    if (!interaction.isCommand()) return;
    const command = client.commands.get(interaction.commandName);
    if (!command) return;

    try {
        await command.execute(interaction);
    } catch (error) {
        if (error) console.error(error);
        await interaction.reply({ content: 'There was an error while executing this command!', ephemeral: true });
    }
});
