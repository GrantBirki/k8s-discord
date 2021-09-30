// This function is useful testing the properties of interaction object
// Import SlashCommandBuild to handle slash commands
const { SlashCommandBuilder } = require('@discordjs/builders');

// Export the module which handles the slash command
module.exports = {
    data: new SlashCommandBuilder()
        .setName('test') // The name of the Discord Slash command
        .setDescription('Returns test info'), // The description of the Discord Slash command

    async execute(interaction) {
        // Sends a reply to the Slash command which triggered this function

        var message = "";
        message += "• interaction.member: " + interaction.member + "\n";
        message += "• interaction.channel: " + interaction.channel + "\n";
        message += "• interaction.channelId: " + interaction.channelId + "\n";
        message += "• interaction.client: " + interaction.client + "\n";
        message += "• interaction.guild: " + interaction.guild + "\n";
        message += "• interaction.guildId: " + interaction.guildId + "\n";
        message += "• interaction.id: " + interaction.id + "\n";
        message += "• interaction.type: " + interaction.type + "\n";
        message += "• interaction.user: " + interaction.user + "\n";
        message += "• interaction.version: " + interaction.version + "\n";

        interaction.reply({ content: message });
    }
};
