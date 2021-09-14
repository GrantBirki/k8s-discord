// Import SlashCommandBuild to handle slash commands
const { SlashCommandBuilder } = require('@discordjs/builders');

// Import our common backend functions
const backend = require("./../common/backend");

// Setup our HTTP library
const bent = require('bent');
const getJSON = bent('json');

// Export the module which handles the slash command
module.exports = {
    data: new SlashCommandBuilder()
        .setName('health') // The name of the Discord Slash command
        .setDescription('Returns the healthcheck of the backend'), // The description of the Discord Slash command

    // The function to execute when the slash command is called (calls our backend)
    async execute(interaction) {
        // Creates the URL to call the backend
        url = await backend.create_url({path: '/api/healthcheck'});
        // Calls the backend with a GET request and returns the JSON response
        let response = await getJSON(url);
        // Sends a reply to the Slash command which triggered this function
        interaction.reply({ content: `Status: ${response.message} - HTTP: ${response.status}` });
    }
};
