#include <cstdlib>
#include <iostream>
#include <cstring>
#include <windows.h>
#include <stdio.h>
//----------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//----------------------------------------------------------------------------
// Lab 5;
// Variant 5;
// 
// Task: 
// - Scope: Library;
// - Attributes: author, title, year of publication, UDC-code, price, count.
// 
// Data struct - in RAM is represented as a bidirectional linear list.
// 
// In the main function should be a structure that describes the menu.
// General program variables: 
// - pointer to the beginning and a pointer to the end of the list;
// - filename to store the list (D_STRUCT.DAT).
// 
// Also should be:
// - Function list print (by 20 elements);
// - Function list input (end of input - when entering name instead 
//   the symbol '*');
// - Function add an item to the list;
// - Function list element delete (overwrite pointers neighboring nodes 
//   and freeing memory);
// - Function changes values list item fields;
// - Function list sorting (by bubble method);
// - Function list save to disk (in file D_STRUCT.DAT);
// - Function list load from file (file D_STRUCT.DAT).
//----------------------------------------------------------------------------
  /* Function prototypes */
int f_exit(struct book**, book**);      // Function exit;
int f_append(book **g,book **p);        // Function input book;
int f_appends(book **g,book **p);       // Function input books;
int f_edit(book **g,book**);            // Function edit book;
int f_view_all(book **g,book**);        // Function view all books;
int f_view_one(book **g,book **p);      // Function view one book;
int f_delete(book **g,book **p);        // Function delete book;
int f_sort(book **g,book **p);          // Function sotring books;
int f_savedtoafile(book **g,book**);    // Function save all books to file;
int f_loadfromfile(book **g,book **p);  // Function load all books from file;

int q_existence(book **);               // Checked exist first record in list;
book* q_select(book **g);               // Selecting book;
int q_filling_fields(book *ftmp,int z); // Filling the book fields;
book* q_sorted(book** a,int r,int n);   // Sorting;
//----------------------------------------------------------------------------

/*
 * Description of the "book" structure.
 */
struct book {
	char author[40];              // Author(s) of the book
	char title[70];               // The title of the book
	unsigned int publishing_year; // Year of publication
	double udc_code;              // Code UDC
	/* UDC - Universal Decimal Classification */
	double price;                 // Price book
	unsigned int amount;          // The number in the library
	struct book *previous;        // A pointer to the previous element
	struct book *next;            // A pointer to the next element
};
//----------------------------------------------------------------------------

/*
 * Description of the structure of "the menu item".
 */
struct item {
	unsigned int el_number;               // Number of menu item
	char* prompt;                         // The text of the menu item
	int (*func_call)(book**, book**);     // A pointer to a function call
};
//----------------------------------------------------------------------------

/*
 * Function exit from program.
 */
int f_exit(struct book**, book**) {
	return 0;
}
//----------------------------------------------------------------------------

/*
 * Function append book.
 */
int f_append(book **g, book **p) { 
	struct book *tmp=NULL, *ftmp=NULL;
	tmp=(*g);
	ftmp=(*p);
	if ((tmp==NULL)&&(ftmp==NULL)) {  // If structure of the first in the list
		tmp=new book;                 // Create first instance of structure
		*g=tmp;      // Sets the pointer to the address of first structure
		*p=tmp;      // Sets the pointer to the address of last structure
		ftmp=(*p);
		tmp->previous=NULL;
	} else {
		tmp=ftmp;
		ftmp=new book;
		ftmp->previous=tmp;
		tmp->next=ftmp;
		*p=ftmp;
	};
	system("cls");
	q_filling_fields(ftmp,0);
	ftmp->next=NULL;
	system("pause");
	return 1;
}
//----------------------------------------------------------------------------

/*
 * Function append books.
 */
int f_appends(book **g, book **p) {
	int fl=1;
	struct book *tmp=NULL,*ftmp=NULL,*buf=NULL;
	tmp=(*g);
	ftmp=(*p);
	system("cls");
	do {
		if ((tmp==NULL)&&(ftmp==NULL)) {  // If structure of first in the list
			tmp=new book; // Create the first instance of structure
			*g=tmp;       // Sets pointer to the address of first structure
			*p=tmp;       // Sets pointer to the address of last structure
			ftmp=tmp;
			tmp->previous=NULL;
		} else {
			buf=ftmp;
			ftmp=new book;
			ftmp->previous=buf;
			buf->next=ftmp;
			*p=ftmp;
			buf=NULL;
		};
		if (q_filling_fields(ftmp,1)) {
			buf=ftmp->previous;
			delete ftmp;
			buf->next=NULL;
			fl=0;
			*p=buf;
		} else {
			ftmp->next=NULL;
			std::cout << "----------------------------------------";
			std::cout << "----------------------------------------" << std::endl;
			std::cout << "To end the input type" << std::endl;
			std::cout << " \"*\" in field \"Author book\";" << std::endl;
			std::cout << "----------------------------------------";
			std::cout << "----------------------------------------" << std::endl;
		}
	} while (fl);
	return 1;
}
//----------------------------------------------------------------------------

/*
 * Function edit book.
 */
int f_edit(book **g, book**) {
	system("cls");
	if (!q_existence(g))       // If a record does not exist,
		return 1;              // the exit function.
	struct book *tmp=NULL;
	tmp=q_select(g);           // Select the record
	std::cout << "_______________________________________________" << std::endl;
	std::cout << "__________________Old record:__________________" << std::endl;
	std::cout << "Author book: " << tmp->author << std::endl;
	std::cout << "Title book: " << tmp->title << std::endl;
	std::cout << "Publishing year book: " << tmp->publishing_year << std::endl;
	std::cout << "UDC-Code: " << tmp->udc_code << std::endl;
	std::cout << "Price book: " << tmp->price << std::endl;
	std::cout << "Number of books: " << tmp->amount << std::endl;
	std::cout << "_______________________________________________" << std::endl;
	std::cout << "__________________New record:__________________" << std::endl;
	q_filling_fields(tmp,0);     // Fill in fields with new values
	std::cout << std::endl << "Changes saved!" << std::endl;
	system("pause");
	return 1;
}
//----------------------------------------------------------------------------

/*
 * Function view a single book.
 */
int f_view_one(book **g,book**) {
	system("cls");
	if (!q_existence(g))       // If a record does not exist,
		return 1;              // the exit function.
	struct book *tmp=NULL;
	tmp=q_select(g);           // Select the record
	std::cout << "_______________________________________________" << std::endl;
	std::cout << "Author book: " << tmp->author << std::endl;
	std::cout << "Title book: " << tmp->title << std::endl;
	std::cout << "Publishing year book: " << tmp->publishing_year << std::endl;
	std::cout << "UDC-Code: " << tmp->udc_code << std::endl;
	std::cout << "Price book: " << tmp->price << std::endl;
	std::cout << "Number of books: " << tmp->amount << std::endl;
	std::cout << "_______________________________________________" << std::endl;
	system("pause");
	return 1;
}
//----------------------------------------------------------------------------

/*
 * Function view all books.
 */
int f_view_all(book **g,book **) {
	system("cls");
	if (!q_existence(g))       // If a record does not exist,
		return 1;              // the exit function.
	struct book *tmp=NULL;
	tmp=(*g);
	std::cout << "Author\t\tTitle\t\tPublish\t";
	std::cout << "UDC-Code\tCost\t\tCount" << std::endl;
	std::cout << "----------------------------------------";
	std::cout << "----------------------------------------" << std::endl;
	unsigned int fl=1,b,ch=0;
	do {
		b=strlen(tmp->author);
		if (b<8) {
			std::cout.write(tmp->author,b);           // piece of code just for
			std::cout << '\t';                        // beauty of the output
		} else 
			if (b<16)
				std::cout.write(tmp->author,b);
			else
				std::cout.write(tmp->author,15);
		std::cout << "\t";
		/*-----------------------------------------*/
		b=strlen(tmp->title);
		if (b<8) {
			std::cout.write(tmp->title,b);            // piece of code just for
			std::cout << '\t';                        // beauty of the output
		} else 
			if (b<16)
				std::cout.write(tmp->title,b);
			else
				std::cout.write(tmp->title,15);
		std::cout << "\t";
		/*-----------------------------------------*/
		std::cout << tmp->publishing_year << '\t';
		std::cout << tmp->udc_code << "\t\t";
		std::cout << tmp->price << "\t\t";
		std::cout << tmp->amount << std::endl;
		if (tmp->next==NULL) 
			fl=0;
		else 
			tmp=tmp->next;
		ch++;
		if (ch%20 == 0) {
			std::cout << "----------------------------------------" << std::endl;
			system("pause");
			std::cout << "----------------------------------------" << std::endl;
		}
	} while (fl);
	std::cout << "----------------------------------------";
	std::cout << "----------------------------------------" << std::endl;
	system("pause");
	return 1;
}
//----------------------------------------------------------------------------

/**
 * Function delete book.
 */
int f_delete(book **g, book **p) {
	system("cls");
	if (!q_existence(g))       // If a record does not exist,
		return 1;              // the exit function.
	struct book *tmp=NULL;
	unsigned int x=1;
	tmp=q_select(g);           // Select the record
	std::cout << "----------------------------------------";
	std::cout << "----------------------------------------" << std::endl;
	std::cout << "Author book: " << tmp->author << std::endl;
	std::cout << "Title book: " << tmp->title << std::endl;
	std::cout << "Publishing year book: " << tmp->publishing_year << std::endl;
	std::cout << "UDC-Code: " << tmp->udc_code << std::endl;
	std::cout << "Price book: " << tmp->price << std::endl;
	std::cout << "Number of books: " << tmp->amount << std::endl;
	std::cout << "----------------------------------------";
	std::cout << "----------------------------------------" << std::endl;
	std::cout << "Are you sure you want to delete this book?" << std::endl;
	std::cout << "(0) - Yes, delete!" << std::endl;
	std::cout << "(1) - No, don't delete!" << std::endl;
	std::cin >> x;
	if (x)
		return 1;               // If the user responded no - exit
	struct book *buf=NULL,*buf2=NULL;
	if ((tmp->next!=NULL)&&(tmp->previous!=NULL)) {      // If before and after
		buf=tmp->next;                                   // book exist books
		buf2=tmp->previous;
		buf2->next=buf;
		buf->previous=buf2; 
	} else if ((tmp->next==NULL)&&(tmp->previous==NULL)) {  // If book is
		 *p=NULL;                                           // only one
		*g=NULL; 
	} else if ((tmp->next!=NULL)&&(tmp->previous==NULL)) {  // If book - first
		buf=tmp->next;
		*g=buf;
		buf->previous=NULL; 
	} else if ((tmp->next==NULL)&&(tmp->previous!=NULL)) {  // If book - last
		buf2=tmp->previous;
		*p=buf2;
		buf2->next=NULL;
	}
	delete tmp;
	std::cout << std::endl << "Book deleted!" << std::endl;
	system("pause");
	return 1;
}
//----------------------------------------------------------------------------

/*
 * Function sorted books.
 */
int f_sort(book **g,book **p) {
	system("cls");
	if (!q_existence(g))       // If a record does not exist,
		return 1;              // the exit function.
	struct book *tmp=NULL,*buf=NULL;
	tmp=(*g);  
	if ((*g)==(*p)) {
		std::cout << "The program is only one book!!" << std::endl;
		system("pause");
		return 1;
	}
	unsigned int n=0,sym;
	while (tmp->next!=NULL) {                // Calculate the size of an array
		tmp=tmp->next;
		n++;
	}
	tmp=(*g);   
	struct book** ar = new struct book*[n];  // Create an array of pointers
	for (unsigned int i=0;i<n+1;i++,tmp=tmp->next)
		ar[i]=tmp;
	std::cout << "Select sorting field:\n1.Author;\n2.Title;\n3.Publishing ";
	std::cout << "year;\n4.UDC-Code;\n5.Price;\n6.Count;\n7.Exit in menu;\n";
	while(1) {
		std::cout << "--> ";
		std::cin >> sym;
		if ((sym>0)&&(sym<8)) break; 
	}
	if (sym==7) 
		return 1;
	else 
		*ar=q_sorted(ar,sym,n);   // sort by selected field
	*g=ar[0];
	tmp=ar[0];
	tmp->previous=NULL;
	for (unsigned int i=1;i<n+1;i++) {
		tmp->next=ar[i];
		buf=tmp;
		ar[i]=NULL;               // <--Do not touch it - this is the magic. 
		tmp=tmp->next;            //    Without it does not work
		tmp->previous=buf; 
	}
	tmp->next=NULL;
	delete []ar;
	return 1;
}
//----------------------------------------------------------------------------

/**
 * Function save all books to file.
 */
int f_savedtoafile(book **g,book**) {
	system("cls");
	if (!q_existence(g))       // If a record does not exist,
		return 1;              // the exit function.
	std::cout << "Are you sure you want to save all the books to a file?";
	std::cout << std::endl << "0 - exit in menu;";
	std::cout << std::endl << "1 - save to file;" << std::endl;
	unsigned short sym;
	unsigned int fl=0;
	while(1) {
		std::cout << "--> ";
		std::cin >> sym;
		if (!sym)
			return 1;
		if (sym==1)
			break;
	}
	FILE *f=NULL;             
	f = fopen("d_struct.dat","wb");
	if (f==NULL) {
		fclose(f);
		std::cout << "Error occurred while creating the file!" << std::endl;
		system("pause");
		return 1;
	}  
	struct book *tmp=NULL;
	tmp=(*g);  
	do {  
		sym=(strlen(tmp->author)+1); //Calculate count of chars field "Author"
		fwrite(&sym,sizeof(unsigned short),1,f);// Write length field "Author"
		fwrite(tmp->author,sym/sizeof(char),1,f);      // Write field "Author"
		sym=(strlen(tmp->title)+1);   //Calculate count of chars field "Title"
		fwrite(&sym,sizeof(unsigned short),1,f); // Write length field "Title"
		fwrite(tmp->title,sym/sizeof(char),1,f);        // Write field "Title"
		fwrite(&tmp->publishing_year,sizeof(unsigned int),1,f);
		fwrite(&tmp->udc_code,sizeof(double),1,f);                 // UDC-Code
		fwrite(&tmp->price,sizeof(double),1,f);                  // Price book
		fwrite(&tmp->amount,sizeof(unsigned int),1,f);     // Count in library
		tmp=tmp->next;
		if (tmp==NULL)                     // This crutch is needed because of 
			fl=1;                          // the imperfection func 'feof ()'.
		fwrite(&fl,sizeof(unsigned int),1,f);
	} while (tmp!=NULL);
	fclose(f);
	return 1;
} 
//----------------------------------------------------------------------------

/**
 * Function load all books from file.
 */
int f_loadfromfile(book **g, book **p) {
	system("cls");
	FILE *f=NULL;             
	f = fopen("d_struct.dat","rb");
	if (f==NULL) {
		fclose(f);
		std::cout << "Error opening the file!" << std::endl;
		system("pause");
		return 1;
	}  
	std::cout << "Are you sure you want to restore a books from a file?";
	std::cout << std::endl << "(All current books will be deleted!)";
	std::cout << std::endl << std::endl << "0 - Exit in menu;";
	std::cout << std::endl << "1 - Load from a file;" << std::endl;
	unsigned short sym;
	while(1) {
		std::cout << "--> ";
		std::cin >> sym;
		if (!sym) {
			fclose(f);
			return 1;
		}
		if (sym==1)
			break;
	}
	struct book *tmp=NULL,*buf=NULL;
	//---------------------------------
	tmp=(*g);                          //
	if (tmp!=NULL) {                   //
		while ((tmp->next)!=NULL) {    //
			buf=tmp->next;             //   Delete all entries
			delete tmp;                //
			tmp=buf;                   //
		}                              //   from RAM
		delete tmp;                    //
		(*g)=NULL;                     //
		(*p)=NULL;                     //
	}                                  //
	//---------------------------------
	short int fl=1;
	unsigned int k;
	while(!feof(f)) {       // Until the end of the file..
		if (fl) {           // If the first record ...
			tmp=new book;
			tmp->previous=NULL;
			(*g)=tmp;
			fl=0;  
		} else { 
			tmp->next=new book;
			buf=tmp;
			tmp=tmp->next;
			tmp->previous=buf;  
		}
		fread(&sym,sizeof(unsigned short),1,f);
		fread(tmp->author,sizeof(char)*sym,1,f);
		fread(&sym,sizeof(unsigned short),1,f);
		fread(tmp->title,sizeof(char)*sym,1,f);
		fread(&tmp->publishing_year,sizeof(unsigned int),1,f);
		fread(&tmp->udc_code,sizeof(double),1,f);
		fread(&tmp->price,sizeof(double),1,f);
		fread(&tmp->amount,sizeof(unsigned int),1,f);
		tmp->next=NULL;
		fread(&k,sizeof(unsigned int),1,f); 
		if (k) {          // End-of-file flag
            (*p)=tmp;
			break;
		}
	}
	fclose(f);
	return 1;
}
//----------------------------------------------------------------------------

/**
 * Check the exist first record.
 */
int q_existence(book **q) {
	if (*q==NULL) {
		std::cout << "No records!!" << std::endl;
		system("pause");
		return 0;
	} else 
		return 1;
}
//----------------------------------------------------------------------------

/**
 * Record selection.
 */
book* q_select(book **g) {
	int n=0,i=1,v=1,ch=0;
	struct book *tmp=NULL;
	tmp=(*g);

	std::cout << "Select book:" << std::endl;
	do {
		ch++;
		if (tmp->next==NULL) 
			v=0;
		std::cout << n << " . " << tmp->author; 
		std::cout << " - " << tmp->title << ";" << std::endl;
		n++;
		if (v) 
			tmp=tmp->next;
		if (ch%20==0) {
			std::cout << "__________________________________________________\n";
			system("pause");
			std::cout << "__________________________________________________\n";
		}
	} while (v);
	while(i) {
		std::cout << "--> ";
		std::cin >> v;
		if (!((v<0)||(v>=n)))
			i=0;
	}
	tmp=(*g);
	for (i=0;i<v;i++)
	tmp=tmp->next;
	return tmp;
}
//----------------------------------------------------------------------------

/**
 * Fill the fields of the structure.
 */
int q_filling_fields(book *ftmp, int z) {
	std::cout << "Enter author: ";
	std::cin.sync();                              // Cleaning the input stream
	std::cin.getline(ftmp->author,sizeof(ftmp->author));
	if (z)
		if ((ftmp->author)[0]==('*')) 
			return 1;
	std::cout << "Enter the title of the book: ";
	std::cin.sync();                              // Cleaning the input stream
	std::cin.getline(ftmp->title,sizeof(ftmp->title));
	std::cout << "Enter the year of publication of the book: ";
	std::cin >> ftmp->publishing_year;
	std::cout << "Enter the code of the UDC: ";
	std::cin >> ftmp->udc_code;
	std::cout << "Enter a price book: ";
	std::cin >> ftmp->price;
	std::cout << "Number of books: ";
	std::cin >> ftmp->amount;
	return 0;
}
//----------------------------------------------------------------------------

/**
 * Array sort algorithm.
 * (Standard exchange method (bubble)).
 */
book* q_sorted(struct book** a,int r,int n) {
	book* buf=NULL;
	for (int i=n;i>0;i--)
		for (int j=0;j<i;j++) {
			switch(r) {
				case 1: 
					if (strcmp(a[j]->author,a[j+1]->author)>0) {
						buf=a[j];
						a[j]=a[j+1];
						a[j+1]=buf;
					};
					break;
				case 2: 
					if (strcmp(a[j]->title,a[j+1]->title)>0) {
						buf=a[j];
						a[j]=a[j+1];
						a[j+1]=buf;
					};
					break;
				case 3: 
					if ((a[j]->publishing_year)>(a[j+1]->publishing_year)) {
						buf=a[j];
						a[j]=a[j+1];
						a[j+1]=buf;
					};
					break;
				case 4: 
					if ((a[j]->udc_code)>(a[j+1]->udc_code)) {
						buf=a[j];
						a[j]=a[j+1];
						a[j+1]=buf;
					};
					break;
				case 5: 
					if ((a[j]->price)>(a[j+1]->price)) { 
						buf=a[j];
						a[j]=a[j+1];
						a[j+1]=buf;
					};
					break;
				case 6: 
					if ((a[j]->amount)>(a[j+1]->amount)) {
						buf=a[j];
						a[j]=a[j+1];
						a[j+1]=buf;
					};
					break;
			}
		}
	return *a;
}
//----------------------------------------------------------------------------

int main(int argc, char *argv[]) {
	unsigned int x;
	int l=1;
	struct book *bbegin=NULL;   // A pointer to the beginning of the list
	struct book *bfinish=NULL;  // A pointer to the end of the list
	system("chcp 1251");

	/*Declare and initialize an array of 10 elements of 'item' structure*/
	item menu[] = {
		{ 1,(char *)"Add book;", &f_append},
		{ 2,(char *)"Add books;", &f_appends},
		{ 3,(char *)"Edit book;", &f_edit},
		{ 4,(char *)"View single book;", &f_view_one},
		{ 5,(char *)"View all books;", &f_view_all},
		{ 6,(char *)"Delete book;", &f_delete},
		{ 7,(char *)"Sort books;", &f_sort},
		{ 8,(char *)"Save list books to file", &f_savedtoafile},
		{ 9,(char *)"Load list books from file", &f_loadfromfile},
		{ 0,(char *)"Exit", &f_exit}
	};
	while (l) {
		system("cls");
		std::cout << "Press:" << std::endl;
		for (int i=0;i<10;i++)
			std::cout << menu[i].el_number << "." << menu[i].prompt << std::endl;
		std::cout << std::endl << std::endl;
		std::cin >> x;
		for (int i=0;i<10;i++)
			if (x==menu[i].el_number) {
				l=menu[i].func_call(&bbegin,&bfinish);
				break;
			}
	}
	return EXIT_SUCCESS;
}

