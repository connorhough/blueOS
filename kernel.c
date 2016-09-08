void main() {
	// create a pointer to a char and point it to the first cell of video memory (top left)
	char* video_memory = (char*) 0xb8000;
	
	// store the character 'X' at this address
	*video_memory = 'X';
}

