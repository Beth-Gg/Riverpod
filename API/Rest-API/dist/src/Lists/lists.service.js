"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ListService = void 0;
const common_1 = require("@nestjs/common");
const mongoose_1 = require("@nestjs/mongoose");
const mongoose_2 = require("mongoose");
let ListService = class ListService {
    constructor(ListModel) {
        this.ListModel = ListModel;
    }
    async insertList(date, content) {
        const listId = new Date().toString();
        const newList = new this.ListModel({ date, content });
        const result = await newList.save();
        console.log(result);
        return result.id;
    }
    async getLists() {
        const Lists = await this.ListModel.find().exec();
        return Lists.map(li => ({
            id: li.id,
            date: li.date,
            content: li.content,
        }));
    }
    async getList(listId) {
        const list = await this.findList(listId);
        return { id: listId, date: list.date, content: list.content };
    }
    async editList(listId, date, listContent) {
        const editedList = await this.findList(listId);
        if (date) {
            editedList.date = date;
        }
        if (listContent) {
            editedList.content = listContent;
        }
        editedList.save();
    }
    async findList(id) {
        let list;
        try {
            list = await this.ListModel.findById(id);
        }
        catch (error) {
            throw new common_1.NotFoundException('No such list!');
        }
        if (!list) {
            throw new common_1.NotFoundException('No such List!');
        }
        return list;
    }
    async deleteList(listId) {
        await this.ListModel.deleteOne({ _id: listId }).exec();
    }
};
exports.ListService = ListService;
exports.ListService = ListService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, mongoose_1.InjectModel)('List')),
    __metadata("design:paramtypes", [mongoose_2.Model])
], ListService);
//# sourceMappingURL=lists.service.js.map