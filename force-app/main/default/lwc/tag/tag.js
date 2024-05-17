import {api, LightningElement} from 'lwc';

export default class Tag extends LightningElement {
    @api name;
    @api color;
    @api tagId;

    handleRemoveTag(){
        this.dispatchEvent(new CustomEvent("removetag", { detail: this.tagId }));
    }
}