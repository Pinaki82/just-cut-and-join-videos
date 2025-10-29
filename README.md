# Just Cut and Join Videos

## The Problem: When "Just Cut and Join" Isn't So Simple

You've been there - a client or colleague hands you a bunch of video clips and says: *"Just cut and join them together. It should take you 5 minutes (**which isn't true at all**), right?"*

What they don't see:

- 🕒 **Your time is valuable** - Even "simple" tasks require your attention
- 💻 **System resources** - Rendering consumes electricity and keeps your machine busy  
- 🎬 **Technical expertise** - Knowing *how* to do it efficiently is a skill worth paying for
- 📊 **Quality control** - Ensuring the final product actually works properly

## The Solution: Automation That Respects Everyone's Time

This script package gives you the power to handle basic video processing tasks yourself, while still recognising when professional expertise is worth paying for.

### What's the point of its Existence?

**For service providers:**

- Automate repetitive "cut and join" requests
- Focus your paid time on creative work that actually requires skill
- Maintain good client relationships by providing tools, not just "no"

**For clients:**

- Stop waiting for someone to be available
- No more travelling with USB drives or coordinating schedules
- Handle urgent small tasks immediately
- Understand what's actually involved in video processing

## What This Script Does

- ✅ Processes all video files in a folder automatically
- ✅ Trims exact frames from start and end of each clip (5 frames from start, 13 from end)
- ✅ De-interlaces old camcorder footage (can be disabled for modern cameras)
- ✅ Combines everything into a clean, watchable final video
- ✅ Saves the result one folder up from your source files

## The Real Value Proposition

**Think about what your time is worth:**

- No more calling someone and waiting for them to be available
- No travelling 1.5km with a USB drive to drop off files
- No back-and-forth messages about when the work will be done
- No worrying about whether you're "bothering" someone with a small task

This script handles the technical part so you can focus on the creative part - or just get on with your day.

## Quick Start

### For Windows Users:

1. Download `process_videos.bat` and `video_length_estimation.bat`
2. Place them in your folder with video files
3. Double-click `process_videos.bat`
4. Find your final video in the parent folder as `final_output.mp4`

### For Linux Users:

1. Download `process_videos.sh` and `video_length_estimation.sh`
2. Make executable: `chmod +x process_videos.sh video_length_estimation.sh`
3. Run: `./process_videos.sh`
4. Find your final video in the parent folder as `final_output.mp4`

## Features

- **Frame-Accurate Trimming**: Uses MXF intermediate for precise frame editing
- **Smart File Handling**: Processes files in correct numerical order
- **Quality Preservation**: Maintains high quality throughout processing
- **Automatic Cleanup**: Removes temporary files automatically
- **Cross-Platform**: Works on both Windows and Linux

## Supported Formats

- MTS/M2TS (Camcorder footage)
- MP4 (Most modern cameras)
- MOV (Apple devices)
- AVI (Legacy formats)
- MKV (Container format)

## Requirements

- **FFmpeg** must be installed and in the system PATH
- **Linux**: `bc` package for calculations (`sudo apt install bc`)

## Usage Notes

### For Different Camera Types:

- **Old Camcorders**: Keep de-interlacing enabled (default)
- **DSLR/Mirrorless/GoPro/Drone**: Remove `yadif` filter from script

### Frame Rate Calculations:

- **25fps**: 5 frames = 0.2s, 13 frames = 0.52s 5 * (Calculation: 1/25 and 13 * 1/25)
- **30fps (NTSC)**: 5 frames = 0.167s, 13 frames = 0.433s (Calculation: 5 * 1/30 and 13 * 1/30)

### Quality Settings:

- Adjust CRF value (18-28) in script for quality/size balance (**Lower value means better quality.** A lower setting results in better quality, but it will also lead to a larger file size.)
- Lower CRF = better quality, larger files
- CRF 23 = good balance (default)

## File Size Estimates

- **1 minute**: ~60 MB
- **10 minutes**: ~600 MB  
- **20 minutes**: ~1.2 GB
- **60 minutes**: ~3.6 GB

## Troubleshooting

### Common Issues:

1. **"FFmpeg not found"**: Install FFmpeg and add to PATH
2. **No video files found**: Check file extensions are supported
3. **Wrong file order**: Ensure files are named numerically (001.MTS, 002.MTS, etc.)
4. **Large file sizes**: Increase CRF value in script

### Performance Tips:

- Process videos in batches under 20 minutes each
- Ensure adequate disk space (MXF files are large temporarily)
- Close other applications during processing for faster rendering

## Scripts Included

- `process_videos.bat` - Main Windows processing script
- `process_videos.sh` - Main Linux processing script  
- `video_length_estimation.bat` - Windows duration calculator
- `video_length_estimation.sh` - Linux duration calculator

## License

MIT-0 (No Attribution Required) - Use freely for any purpose, personal or commercial.

---

*Sometimes, the most polite solution is giving people the tools to help themselves, while maintaining the value of your professional expertise for the work that truly deserves it.*

**When to call a professional:** Colour grading, audio mixing, special effects, complex editing, precise cuts and organising the clips, video titling, and anything that requires creative decision-making.

---

## Acknowledgments

- **DeepSeek** for initial script development and writing the documentation
- **FFmpeg** team for the incredible multimedia framework
- The video editing community for continuous improvement

*Remember: Tools automate tasks, but creativity and expertise will always have value.*

---

The Bengali version of this self-help guide (Also written by DeepSeek):

---

# শুধু ভিডিও কাটুন এবং জুড়ুন

## সমস্যা: যখন "শুধু কাটুন এবং জুড়ুন" ঠিক ততটাও সহজ নয়

আপনি নিশ্চয়ই এই পরিস্থিতির মুখোমুখি হয়েছেন - একজন ক্লায়েন্ট বা সহকর্মী আপনাকে কিছু ভিডিও ক্লিপ দিয়ে বলে: *"শুধু কাটুন এবং জুড়ে দিন। আপনার ৫ মিনিট লাগবে (**যা একদমই সত্য নয়**), তাই না?"*

তারা যা দেখতে পায় না:

- 🕒 **আপনার সময় মূল্যবান** - এমনকি "সহজ" কাজগুলিরও আপনার মনোযোগ প্রয়োজন
- 💻 **সিস্টেম রিসোর্স** - রেন্ডারিং ও কনভার্সন করতে বিদ্যুৎ খরচ হয় এবং আপনার মেশিন সেই কাজে দীর্ঘ সময় ব্যস্ত থাকে
- 🎬 **প্রযুক্তিগত দক্ষতা** - কিভাবে দক্ষতার সাথে করা যায় তা জানা একটি দক্ষতা যা অর্জনের মূল্য আছে
- 📊 **গুণমান নিয়ন্ত্রণ** - চূড়ান্ত ফলাফলটি আসলে সঠিক আছে কি না, তা নিশ্চিত করা

## সমাধান: অটোমেশন - যা সবার সময়কে সম্মান করে

এই স্ক্রিপ্ট প্যাকেজ আপনাকে মৌলিক ভিডিও প্রসেসিং কাজগুলি নিজে পরিচালনা করার ক্ষমতা দেয়, পাশাপাশি পেশাদার দক্ষতা কখন অর্থ প্রদানের যোগ্য তা চিনতেও সাহায্য করে।

### এর অস্তিত্বের কারণ কী?

**সেবা প্রদানকারীদের (ভিডিও এডিটর, ইত্যাদি) জন্য:**

- পুনরাবৃত্তিমূলক "কাটুন এবং জুড়ুন" অনুরোধগুলি স্বয়ংক্রিয় করুন
- আপনার প্রদত্ত সময়টি সৃজনশীল কাজের উপর ফোকাস করুন যার জন্য আসলে দক্ষতার প্রয়োজন
- শুধু "না" বলার পরিবর্তে সাধনী উন্মোচন করে ক্লায়েন্টের সঙ্গে ভাল সম্পর্ক বজায় রাখুন

**ক্লায়েন্টদের জন্য:**

- কারো উপলব্ধ হওয়ার জন্য অপেক্ষা করা বন্ধ করুন
- USB ড্রাইভ নিয়ে ভ্রমণ, ঘন ঘন মেসেজ, বা সময়সূচী সমন্বয় করার প্রয়োজন নেই
- জরুরী ছোট কাজগুলি অবিলম্বে নিজই সম্পাদন করুন
- ভিডিও প্রসেসিংয়ের কার্যে আসলে কী জড়িত তা বুঝুন

## এই স্ক্রিপ্টটি কী করে

- ✅ একটি ফোল্ডারে সমস্ত ভিডিও ফাইল স্বয়ংক্রিয়ভাবে প্রসেস করে
- ✅ প্রতিটি ক্লিপের শুরু এবং শেষ থেকে সঠিক ফ্রেম সংখ্যা অপসরণ করে দেয় (শুরু থেকে ৫ ফ্রেম, শেষ থেকে ১৩ ফ্রেম)
- ✅ পুরানো ক্যামকর্ডার ফুটেজ ডি-ইন্টারলেস করে (যেটি আধুনিক ক্যামেরার জন্য নিষ্ক্রিয় করা যাবে)
- ✅ সবকিছু একটি পরিষ্কার, দেখার যোগ্য চূড়ান্ত ভিডিওতে একত্রিত করে
- ✅ ফলাফলটি আপনার সোর্স ফাইল থেকে এক লেভেল উপরের ফোল্ডারে সংরক্ষণ করে (যে ফোল্ডারে ক্যামকর্ডার ফুটেজ আছে ঠিক তার বাহিরে)

## আসলে মূল্য প্রস্তাবনা

**চিন্তা করুন আপনার সময়ের মূল্য কত:**

- আর কাউকে ফোন করে তাদের উপলব্ধ হওয়ার জন্য অপেক্ষা করতে হবে না
- ফাইল ড্রপ করতে USB ড্রাইভ নিয়ে ১.৫ কিমি ভ্রমণ করতে হবে না
- কাজ কখন হবে তা নিয়ে বার্তা আদান-প্রদান করতে হবে না
- ছোট কাজ দিয়ে কাউকে "বিরক্ত" করছেন কিনা তা নিয়ে চিন্তা করতে হবে না

এই স্ক্রিপ্টটি প্রযুক্তিগত অংশটি পরিচালনা করে যাতে আপনি সৃজনশীল অংশে ফোকাস করতে পারেন - অথবা শুধু আপনার দিনটি অন্য প্রয়োজনীয় কাজে কাটিয়ে নিতে পারেন।

## দ্রুত শুরুর বর্ণনা

### উইন্ডোজ ব্যবহারকারীদের জন্য:

১. `process_videos.bat` এবং `video_length_estimation.bat` ডাউনলোড করুন

২. এগুলি আপনার ভিডিও ফাইল সহ ফোল্ডারে রাখুন

৩. `process_videos.bat` এ ডাবল-ক্লিক করুন

৪. আপনার চূড়ান্ত ভিডিওটি প্যারেন্ট ফোল্ডারে (যে ফোল্ডারে ক্যামকর্ডার ফুটেজ আছে ঠিক তার বাহিরে) `final_output.mp4` হিসাবে খুঁজুন

### লিনাক্স ব্যবহারকারীদের জন্য:

১. `process_videos.sh` এবং `video_length_estimation.sh` ডাউনলোড করুন

২. এক্সিকিউটেবল করুন: `chmod +x process_videos.sh video_length_estimation.sh`

৩. চালান: `./process_videos.sh`

৪. আপনার চূড়ান্ত ভিডিওটি প্যারেন্ট ফোল্ডারে (যে ফোল্ডারে ক্যামকর্ডার ফুটেজ আছে ঠিক তার বাহিরে) `final_output.mp4` হিসাবে খুঁজুন

## বৈশিষ্ট্য

- **ফ্রেম-সঠিক ট্রিমিং**: সঠিক ফ্রেম এডিটিংয়ের জন্য MXF ইন্টারমিডিয়েট কোডেক ব্যবহার করে
- **স্মার্ট ফাইল হ্যান্ডলিং**: সঠিক সংখ্যাসূচক ক্রমে ফাইল প্রসেস করে
- **গুণমান সংরক্ষণ**: প্রসেসিং জুড়ে উচ্চ গুণমান বজায় রাখে
- **স্বয়ংক্রিয় ক্লিনআপ**: অটোমেটিকভাবে অস্থায়ী ফাইল মুছে দেয়
- **ক্রস-প্ল্যাটফর্ম**: উইন্ডোজ এবং লিনাক্স উভয়তেই কাজ করে

## সমর্থিত ফরম্যাট

- MTS/M2TS (ক্যামকর্ডার ফুটেজ)
- MP4 (বেশিরভাগ আধুনিক ক্যামেরা)
- MOV (অ্যাপল ডিভাইস)
- AVI (লিগ্যাসি ফরম্যাট)
- MKV (কন্টেইনার ফরম্যাট)

## প্রয়োজনীয়তা

- **FFmpeg** ইনস্টল করা থাকতে হবে এবং FFMPEG-এর `bin` ফোল্ডার সিস্টেম PATH-এ থাকতে হবে
- **লিনাক্স**: মৌলিক গণনার জন্য `bc` প্যাকেজ: ডেবিয়ান ইত্যাদি: (`sudo apt install bc`)

## ব্যবহারের নোট

### বিভিন্ন ক্যামেরা প্রকারের জন্য:

- **পুরানো ক্যামকর্ডার**: ডি-ইন্টারলেসিং সক্ষম রাখুন (ডিফল্ট)
- **DSLR/মিররলেস/GoPro/ড্রোন**: স্ক্রিপ্ট থেকে `yadif` ফিল্টার অপসরণ করুন

### ফ্রেম রেট ক্যালকুলেশন:

- **25fps**: 5 ফ্রেম = 0.2s, 13 ফ্রেম = 0.52s (5 * 1/25 এবং 13 * 1/25)
- **30fps (NTSC)**: 5 ফ্রেম = 0.167s, 13 ফ্রেম = 0.433s (5 * 1/30 এবং 13 * 1/30))

### গুণমান সেটিংস:

- গুণমান/আকার ব্যালেন্সের জন্য স্ক্রিপ্টে CRF মান (18-28) সামঞ্জস্য করুন
- নিম্ন CRF = ভাল গুণমান, বড় ফাইল (এক্ষেত্রে, CRF কম মানে ভাল, তবে ফাইল বড় হয়ে থাকে)
- CRF 23 = ভাল ব্যালেন্স (ডিফল্ট)

## ফাইল সাইজ আনুমানিক

- **১ মিনিট**: ~60 MB
- **১০ মিনিট**: ~600 MB
- **২০ মিনিট**: ~1.2 GB
- **৬০ মিনিট**: ~3.6 GB

## সমস্যা সমাধান

### সাধারণ সমস্যা:

১. **"FFmpeg পাওয়া যায়নি"**: FFmpeg ইনস্টল করুন এবং FFMPEG-এর `bin` ফোল্ডার PATH-এ যোগ করুন

২. **কোন ভিডিও ফাইল পাওয়া যায়নি**: ফাইল এক্সটেনশন সমর্থিত কিনা তা পরীক্ষা করুন

৩. **ভুল ফাইল অর্ডার**: ফাইলগুলি সংখ্যাসূচকভাবে নামকরণ করা হয়েছে তা নিশ্চিত করুন (001.MTS, 002.MTS, ইত্যাদি)

৪. **বড় ফাইল সাইজ**: স্ক্রিপ্টে CRF মান বাড়ান

### পারফরম্যান্স টিপস:

- একবারে ২০ মিনিটের কম ভিডিও প্রসেস করুন
- পর্যাপ্ত খালি ডিস্ক স্পেস নিশ্চিত করুন (MXF ফাইলগুলি অস্থায়ীভাবে বড় হয়, যদিও সেগুলি পরে ডিলিট হয়ে যায়)
- দ্রুত রেন্ডারিংয়ের জন্য প্রসেসিং চলাকালীন অন্যান্য অ্যাপ্লিকেশন বন্ধ করুন

## অন্তর্ভুক্ত স্ক্রিপ্টগুলি

- `process_videos.bat` - প্রধান উইন্ডোজ প্রসেসিং স্ক্রিপ্ট
- `process_videos.sh` - প্রধান লিনাক্স প্রসেসিং স্ক্রিপ্ট
- `video_length_estimation.bat` - উইন্ডোজ সময়কাল ক্যালকুলেটর
- `video_length_estimation.sh` - লিনাক্স সময়কাল ক্যালকুলেটর

## লাইসেন্স

MIT-0 (কোন অ্যাট্রিবিউশন প্রয়োজন নেই) - যেকোনো উদ্দেশ্যে বিনামূল্যে ব্যবহার করুন, ব্যক্তিগত বা বাণিজ্যিক।

---

*কখনও কখনও, সবচেয়ে ভদ্র সমাধান হল মানুষকে নিজেকে সাহায্য করার সাধনী দেওয়া, পাশাপাশি সেই কাজের জন্য আপনার পেশাদার দক্ষতার মূল্য বজায় রাখা যা সত্যিই এর যোগ্য।*

**কখন একজন পেশাদারকে ডাকবেন:** কালার গ্রেডিং, অডিও মিক্সিং, বিশেষ ইফেক্ট, জটিল এডিটিং, সঠিক কাট এবং ক্লিপ সংগঠিত করা, ভিডিও টাইটেলিং, এবং যেকোনো কিছু যার জন্য সৃজনশীল সিদ্ধান্ত নেওয়ার প্রয়োজন।

---

## স্বীকৃতি

- **DeepSeek** প্রাথমিক স্ক্রিপ্ট ডেভেলপমেন্ট এবং ডকুমেন্টেশন লেখার জন্য (তা ছাড়াও, বাংলায় অনুবাদ করার জন্য)
- **FFmpeg** দল - ঐই অবিশ্বাস্য ক্ষমতাসম্পন্ন মাল্টিমিডিয়া ফ্রেমওয়ার্কের জন্য
- ভিডিও এডিটিং পদ্ধতির ক্রমাগত উন্নতির জন্য ভিডিও এডিটিং কমিউনিটি

*মনে রাখবেন: যন্ত্র এক ভুমিকা পালন করে যা হল একই ছকে চলা কাজগুলি স্বয়ংক্রিয় করা, কিন্তু সৃজনশীলতা এবং দক্ষতার সর্বদা মূল্য থাকবে।*
