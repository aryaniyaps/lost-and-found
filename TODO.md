# TODO: Implement Email Notifications and Enhanced Matching System

## Email Notification System

- [ ] Add Spring Boot Mail dependency to pom.xml
- [x] Configure email properties in application.properties
- [x] Create EmailService for sending notifications
- [x] Modify ItemService.createItem to send email when FOUND item matches LOST item
- [x] Send email to LOST item owner when FOUND item is reported

## Enhanced Matching System

- [x] Create ItemLink entity for linking FOUND to LOST items
- [x] Add ItemLinkRepository
- [x] Modify ItemService.createItem to check for existing LOST items and link if match found
- [x] Update ItemController to show linked items in UI
- [x] Modify item-detail.jsp to display linked items

## UI Updates

- [x] Update item-detail.jsp to show linked items section
- [x] Add notification when items are linked

## Testing

- [ ] Test email sending when FOUND item matches LOST item
- [ ] Test linking functionality
- [ ] Verify UI displays linked items correctly
