// This function is useful for checking the frontend container health
// Import SlashCommandBuild to handle slash commands
const { SlashCommandBuilder } = require('@discordjs/builders');

// Export the module which handles the slash command
module.exports = {
    data: new SlashCommandBuilder()
        .setName('ping') // The name of the Discord Slash command
        .setDescription('Returns pong'), // The description of the Discord Slash command

    // The function to execute when the slash command is called (calls our backend)
    async execute(interaction) {
        // Sends a reply to the Slash command which triggered this function
        interaction.reply({ content: "pong" });
    }
};
