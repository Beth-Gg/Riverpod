import { ListService } from './lists.service';
export declare class ListsController {
    private readonly listsService;
    constructor(listsService: ListService);
    createList(listDate: string, listContent: string): Promise<{
        id: any;
    }>;
    getAllLists(): Promise<{
        id: any;
        date: string;
        content: string;
    }[]>;
    getSingleList(listId: string): Promise<{
        id: string;
        date: string;
        content: string;
    }>;
    editList(listId: string, date: string, listContent: string): Promise<any>;
    deleteList(listId: string): Promise<any>;
}
