// This file registers all all the Slash commands for the bot
// It should only be run when a new command is added, or removed

// Require Dependencies
const { REST } = require('@discordjs/rest');
const { Routes } = require('discord-api-types/v9');
const dotenv = require('dotenv');
const fs = require('fs');

// Load env vars
dotenv.config();
const TEST_GUILD_ID = process.env.TEST_GUILD_ID;
const DISCORD_TOKEN = process.env.DISCORD_TOKEN;
const CLIENT_ID = process.env.CLIENT_ID;

// Creats a new client object
const { Client, Intents, Collection } = require('discord.js');
const client = new Client({ intents: [Intents.FLAGS.GUILDS] });

// Loads all the command files
const commandFiles = fs.readdirSync('./commands').filter(file => file.endsWith('.js'));

// Creating a collection for commands in client
const commands = [];
client.commands = new Collection();
for (const file of commandFiles) {
    const command = require(`./commands/${file}`);
    commands.push(command.data.toJSON());
    client.commands.set(command.data.name, command);
}

// Create REST client
const rest = new REST({ version: '9' }).setToken(DISCORD_TOKEN);

// Load and refresh all available Slash commands
(async () => {
  try {
    console.log('Started refreshing application (/) commands.');

    // Production - Enable commands globally for all guilds
    if (!TEST_GUILD_ID) {
        await rest.put(
            Routes.applicationCommands(CLIENT_ID), {
                body: commands
            },
        );
        console.log('Successfully registered application commands globally');
    // Development - Enable commands only for the test guild
    } else {
        await rest.put(
            Routes.applicationGuildCommands(CLIENT_ID, TEST_GUILD_ID), {
                body: commands
            },
        );
        console.log('Successfully registered application commands for development guild');
    }

    console.log('Successfully reloaded application (/) commands.');
  } catch (error) {
    console.error(error);
  }
})();
