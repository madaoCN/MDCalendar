# MDCalendar

a simple calendar demo as following

![calendar.png](https://github.com/madaoCN/MDCalendar/blob/master/calendar.png)


using collectionview to realize the calendar
```swift
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: MADCalendarCell.self), for: indexPath) as! MADCalendarCell
        
        if indexPath.row < self.weekTitles.count {
            cell.titleLabel.text = self.weekTitles[indexPath.row]
        }else {
            let index = indexPath.row - self.weekTitles.count
            if index < self.currentMonthData.dayArr.count {                
                cell.model = self.currentMonthData.dayArr[index]
            }
        }
        return cell
    }
```

![calendar.gif](https://github.com/madaoCN/MDCalendar/blob/master/calendar.gif)

it is too simple，so i have no more thing to be written.
