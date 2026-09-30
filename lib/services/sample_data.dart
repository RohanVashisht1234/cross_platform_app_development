import '../models/day_of_week.dart';
import '../models/difficulty.dart';
import '../models/ingredient.dart';
import '../models/meal_plan_entry.dart';
import '../models/meal_slot.dart';
import '../models/recipe.dart';
import '../models/weekly_meal_plan.dart';

/// Provides curated 100% pure sattvic vegetarian recipes
/// with intentional overlapping ingredients to showcase the Map-based merging logic in the weekly meal plan.
class SampleData {
  static List<Recipe> get initialRecipes => [
        // 1. Shahi Paneer Butter Masala
        Recipe(
          id: 'rec_shahi_paneer',
          title: 'Shahi Paneer Butter Masala',
          description:
              'Soft, golden-seared artisanal paneer simmered in a velvety tomato, cashew nut, and aromatic ginger-cardamom gravy finished with fresh cream and kasuri methi. 100% sattvic with zero alliums.',
          category: 'North Indian',
          imageUrl: 'assets/images/shahi_paneer.png',
          prepTimeMinutes: 15,
          cookTimeMinutes: 20,
          difficulty: Difficulty.medium,
          servings: 4,
          calories: 480,
          tags: ['PURE VEGETARIAN', 'SATTVIC / NO ALLIUM', 'Comfort Food', 'Royal Feast'],
          ingredients: [
            Ingredient(
              name: 'Fresh Malai Paneer',
              amount: 400,
              unit: 'g',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Vine Ripe Tomatoes',
              amount: 500,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Raw Cashew Nuts',
              amount: 80,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Pure Desi Ghee',
              amount: 3,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Fresh Ginger Root',
              amount: 25,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Kasuri Methi',
              amount: 1,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Fresh Heavy Cream',
              amount: 60,
              unit: 'ml',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Whole Spices (Cardamom, Cumin, Hing)',
              amount: 1,
              unit: 'tsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'Temper Whole Spices & Ginger: Heat desi ghee in a heavy copper kadai. Crackle cumin seeds and hing, then add freshly grated ginger and slit green chillies until fragrant.',
            'Simmer Rich Tomato Cashew Base: Pour in fresh tomato puree and cashew paste. Simmer gently until ghee surfaces and gravy turns velvety smooth.',
            'Add Paneer & Cream: Gently fold in soft paneer cubes, crushed kasuri methi, garam masala, and fresh cream. Warm on low heat for 3 minutes before serving with hot naan or jeera rice.',
          ],
        ),

        // 2. Creamy Palak Paneer
        Recipe(
          id: 'rec_palak_paneer',
          title: 'Creamy Palak Paneer',
          description:
              'Fresh malai paneer cubes nestled in a vibrant blanched spinach gravy infused with fresh ginger, cumin seeds, and a swirl of churned butter.',
          category: 'North Indian',
          imageUrl: 'assets/images/palak_paneer.png',
          prepTimeMinutes: 15,
          cookTimeMinutes: 10,
          difficulty: Difficulty.easy,
          servings: 4,
          calories: 360,
          tags: ['Pure Vegetarian', 'High Iron', 'Sattvic', 'Healthy Greens'],
          ingredients: [
            Ingredient(
              name: 'Fresh Baby Spinach',
              amount: 500,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Malai Paneer',
              amount: 350,
              unit: 'g',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Fresh Ginger Root',
              amount: 20,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Cumin Seeds & Hing',
              amount: 1,
              unit: 'tsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'White Butter',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Fresh Heavy Cream',
              amount: 40,
              unit: 'ml',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Green Chilies',
              amount: 2,
              unit: 'pcs',
              category: IngredientCategory.produce,
            ),
          ],
          instructions: [
            'Blanch washed spinach leaves in boiling water for 2 minutes, then plunge immediately into an ice bath to retain its emerald green hue.',
            'Puree blanched spinach with green chilies into a silky smooth puree without adding excess water.',
            'Heat butter in a pan. Splutter cumin seeds, hing, and sauté ginger juliennes until fragrant.',
            'Pour in the emerald spinach puree, add garam masala, and simmer on gentle heat for 5 minutes.',
            'Gently submerge fresh paneer cubes into the warm simmering gravy.',
            'Finish with fresh lemon juice, a swirl of heavy cream, and serve warm with roti or paratha.',
          ],
        ),

        // 3. Slow-Cooked Dal Makhani
        Recipe(
          id: 'rec_dal_makhani',
          title: 'Slow-Cooked Dal Makhani',
          description:
              'Whole black urad lentils and red kidney beans slow-simmered in an artisanal copper pot with crushed ginger, ripe tomatoes, butter, and cream.',
          category: 'Curries & Dal',
          imageUrl: 'assets/images/dal_makhani.png',
          prepTimeMinutes: 15,
          cookTimeMinutes: 25,
          difficulty: Difficulty.medium,
          servings: 4,
          calories: 390,
          tags: ['Pure Vegetarian', 'High Protein', 'Slow Cooked', 'Traditional'],
          ingredients: [
            Ingredient(
              name: 'Whole Black Urad Dal',
              amount: 250,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Kidney Beans (Rajma)',
              amount: 60,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'White Butter',
              amount: 60,
              unit: 'g',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Fresh Heavy Cream',
              amount: 80,
              unit: 'ml',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Vine Ripe Tomatoes',
              amount: 400,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Ginger Root',
              amount: 25,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Kasuri Methi',
              amount: 1,
              unit: 'tsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Pure Desi Ghee',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
          ],
          instructions: [
            'Pressure cook soaked black lentils and kidney beans with salt and water for 6-7 whistles until completely soft and mashable.',
            'In a heavy-bottomed pot, melt desi ghee with cumin seeds, hing, and crushed fresh ginger.',
            'Add pureed ripe tomatoes and Kashmiri chili powder; cook until a fragrant reduced masala forms.',
            'Add cooked lentils along with their cooking liquor. Mash a portion of the lentils with the back of a ladle to yield that signature creamy body.',
            'Slow simmer on low heat for 25-30 minutes, stirring periodically to prevent sticking.',
            'Stir in churned butter, crushed kasuri methi, and fresh heavy cream right before serving hot with crisp naan.',
          ],
        ),

        // 4. Royal Vegetable Dum Biryani
        Recipe(
          id: 'rec_vegetable_biryani',
          title: 'Royal Vegetable Dum Biryani',
          description:
              'Fragrant saffron-infused aged basmati rice layered with baby potatoes, sweet peas, golden carrots, fresh mint, and toasted cashews, sealed and dum-cooked.',
          category: 'Rice Special',
          imageUrl: 'assets/images/vegetable_biryani.png',
          prepTimeMinutes: 25,
          cookTimeMinutes: 30,
          difficulty: Difficulty.hard,
          servings: 6,
          calories: 450,
          tags: ['Pure Vegetarian', 'Royal Feast', 'Aromatic', 'Dum Style'],
          ingredients: [
            Ingredient(
              name: 'Aged Saffron Basmati Rice',
              amount: 500,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Baby Potatoes',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Green Peas',
              amount: 150,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Vine Ripe Tomatoes',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Mint & Cilantro',
              amount: 2,
              unit: 'bunches',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Raw Cashew Nuts',
              amount: 50,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Pure Desi Ghee',
              amount: 4,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Cardamom Pods & Saffron',
              amount: 1,
              unit: 'tsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'Parboil washed basmati rice in salted water with whole cardamom pods until 70% cooked; drain immediately.',
            'In a deep handi, saute potatoes, carrots, and sweet green peas with cumin seeds, ginger, and aromatic spices until half tender.',
            'Layer the spiced vegetables at the bottom of the handi. Spread fragrant parboiled basmati rice evenly over top.',
            'Scatter fresh mint leaves, toasted whole cashews, and drizzle warm saffron-infused milk across the surface.',
            'Dot with churned butter, seal the pot tightly with foil or dough, and dum-cook on lowest heat for 20 minutes.',
            'Rest for 5 minutes before gently fluffing the layered grains with a fork. Serve with cooling cucumber raita.',
          ],
        ),

        // 5. Banarasi Dum Aloo
        Recipe(
          id: 'rec_banarasi_dum_aloo',
          title: 'Banarasi Dum Aloo',
          description:
              'Golden-fried baby potatoes slow-cooked in a rich, tangy gravy of vine tomatoes, fresh yogurt, fennel, and dry ginger powder. Authentic sattvic Banarasi style.',
          category: 'North Indian',
          imageUrl: 'assets/images/white_bean_skillet.png',
          prepTimeMinutes: 15,
          cookTimeMinutes: 20,
          difficulty: Difficulty.medium,
          servings: 4,
          calories: 370,
          tags: ['Pure Vegetarian', 'Banarasi Heritage', 'Sattvic', 'Spiced Gravy'],
          ingredients: [
            Ingredient(
              name: 'Baby Potatoes',
              amount: 500,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Vine Ripe Tomatoes',
              amount: 350,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Yogurt (Dahi)',
              amount: 150,
              unit: 'g',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Fresh Ginger Root',
              amount: 20,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Pure Desi Ghee',
              amount: 2.5,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Fennel & Dry Ginger Powder (Saunth)',
              amount: 1.5,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Asafoetida (Hing) & Cumin Seeds',
              amount: 1,
              unit: 'tsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'Boil baby potatoes until just tender. Peel and prick with a fork, then shallow fry in ghee until golden and crisp.',
            'Whisk fresh yogurt with dry ginger powder, fennel powder, turmeric, and coriander powder into a smooth paste.',
            'Heat ghee in a pan, crackle cumin seeds and hing. Add pureed tomatoes and cook until oil separates.',
            'Lower heat and stir in the spiced yogurt mixture continuously to prevent curdling.',
            'Add golden potatoes, cover with a tight lid, and simmer on dum for 12 minutes until potatoes absorb the rich flavors.',
            'Garnish with fresh coriander and serve piping hot with phulkas or poori.',
          ],
        ),

        // 6. Traditional Vegetable Sambhar
        Recipe(
          id: 'rec_sambhar_idli',
          title: 'South Indian Vegetable Sambhar',
          description:
              'Aromatic toor dal simmered with drumsticks, tender pumpkin, carrots, tangy tamarind pulp, and tempered with mustard seeds, curry leaves, and fragrant hing.',
          category: 'South Indian',
          imageUrl: 'assets/images/dal_makhani.png',
          prepTimeMinutes: 15,
          cookTimeMinutes: 20,
          difficulty: Difficulty.easy,
          servings: 5,
          calories: 280,
          tags: ['Pure Vegetarian', 'South Indian Classic', 'High Protein', 'Tangy & Comforting'],
          ingredients: [
            Ingredient(
              name: 'Toor Dal (Pigeon Pea Lentils)',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Drumsticks & Pumpkin',
              amount: 250,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Tamarind Pulp',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Fresh Curry Leaves & Mustard Seeds',
              amount: 1,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Pure Desi Ghee',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Asafoetida (Hing) & Sambhar Masala',
              amount: 1.5,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Vine Ripe Tomatoes',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
          ],
          instructions: [
            'Pressure cook toor dal with turmeric and water until soft and mushy; whisk until smooth.',
            'In a pot, boil drumsticks, pumpkin cubes, and tomatoes in tamarind water with sambhar powder and salt until tender.',
            'Pour in the whisked cooked dal, bring to a rolling boil, and adjust consistency with warm water.',
            'Prepare the aromatic tadka: Heat ghee, crackle mustard seeds, dried red chilies, fresh curry leaves, and a generous pinch of hing.',
            'Pour sizzling tempering over the boiling sambhar and cover immediately with a lid to trap the aroma.',
            'Serve piping hot with steamed idlis, medu vada, or hot steamed rice.',
          ],
        ),

        // 7. Crispy Ghee Roast Dosa
        Recipe(
          id: 'rec_ghee_masala_dosa',
          title: 'Crispy Ghee Roast Dosa',
          description:
              'Paper-thin fermented rice and lentil crepe roasted golden with pure A2 desi ghee, stuffed with turmeric-ginger spiced potatoes, paired with fresh coconut chutney.',
          category: 'South Indian',
          imageUrl: 'assets/images/vegetable_biryani.png',
          prepTimeMinutes: 10,
          cookTimeMinutes: 15,
          difficulty: Difficulty.medium,
          servings: 3,
          calories: 390,
          tags: ['Pure Vegetarian', 'Breakfast Favorite', 'Crispy', 'Iconic'],
          ingredients: [
            Ingredient(
              name: 'Fermented Dosa Batter',
              amount: 500,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Boiled Potatoes',
              amount: 300,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Pure Desi Ghee',
              amount: 4,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Fresh Grated Coconut',
              amount: 100,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Ginger Root',
              amount: 15,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Mustard Seeds & Curry Leaves',
              amount: 1,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'Prepare potato filling: Heat ghee, splutter mustard seeds, curry leaves, grated ginger, and green chilies. Add mashed boiled potatoes and turmeric; mix well.',
            'Blend freshly grated coconut with roasted gram, green chilies, ginger, and temper with mustard seeds for the chutney.',
            'Heat a seasoned cast iron tawa until water droplets sizzle. Pour a ladle of batter and swirl into a thin disc.',
            'Generously drizzle pure desi ghee around the edges and center. Roast on medium heat until lacey, golden, and ultra-crisp.',
            'Place a portion of spiced potato masala in the center, fold over, and serve immediately with coconut chutney and hot sambhar.',
          ],
        ),

        // 8. Kashmiri Nadru Yakhni
        Recipe(
          id: 'rec_kashmiri_nadru',
          title: 'Kashmiri Nadru Yakhni',
          description:
              'Crispy lotus stem rounds gently simmered in a fragrant whole-spice yogurt gravy infused with dry ginger (saunth) and fennel powder. 100% pure sattvic culinary recipe.',
          category: 'Curries & Dal',
          imageUrl: 'assets/images/palak_paneer.png',
          prepTimeMinutes: 15,
          cookTimeMinutes: 20,
          difficulty: Difficulty.hard,
          servings: 4,
          calories: 340,
          tags: ['Pure Vegetarian', 'Kashmiri Heritage', 'Sattvic', 'Aromatic Yakhni'],
          ingredients: [
            Ingredient(
              name: 'Fresh Lotus Stem (Nadru)',
              amount: 350,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Yogurt (whisked)',
              amount: 400,
              unit: 'g',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Pure Desi Ghee',
              amount: 3,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Fennel Powder (Saunf)',
              amount: 1,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Dry Ginger Powder (Saunth)',
              amount: 1,
              unit: 'tsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Black Cardamom & Cloves',
              amount: 1,
              unit: 'tsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Hing (Asafoetida)',
              amount: 0.5,
              unit: 'tsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'Wash lotus stems thoroughly to remove silt. Slice diagonally into 1/2-inch discs and parboil with turmeric for 5 minutes.',
            'Shallow fry parboiled lotus stems in desi ghee until light golden and crisp on both sides.',
            'Whisk fresh yogurt in a heavy pot over low flame continuously in one direction until it comes to a gentle boil without curdling.',
            'Stir in fennel powder, saunth powder, cloves, black cardamom, and hing dissolved in water.',
            'Add the fried lotus stem rounds into the boiling yogurt gravy. Simmer on low heat for 12 minutes until gravy thickens.',
            'Finish with dried crushed mint leaves and serve hot with steamed Kashmiri basmati rice.',
          ],
        ),

        // 9. Methi Malai Matar
        Recipe(
          id: 'rec_methi_malai_matar',
          title: 'Creamy Methi Malai Matar',
          description:
              'Fresh tender fenugreek leaves and sweet green peas simmered in a velvety cashew and fresh cream gravy scented with green cardamom and ginger.',
          category: 'North Indian',
          imageUrl: 'assets/images/shahi_paneer.png',
          prepTimeMinutes: 15,
          cookTimeMinutes: 15,
          difficulty: Difficulty.medium,
          servings: 4,
          calories: 420,
          tags: ['Pure Vegetarian', 'Winter Classic', 'Creamy Gravy', 'Sattvic'],
          ingredients: [
            Ingredient(
              name: 'Fresh Fenugreek Leaves (Methi)',
              amount: 250,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Sweet Green Peas',
              amount: 250,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Raw Cashew Nuts',
              amount: 100,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Fresh Heavy Cream',
              amount: 100,
              unit: 'ml',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Pure Desi Ghee',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Fresh Ginger Root',
              amount: 15,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Green Cardamom & Cumin',
              amount: 1,
              unit: 'tsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'Chop fresh methi leaves, sprinkle with a pinch of salt, and let sit for 10 minutes; squeeze out bitter water and saute lightly in ghee.',
            'Boil green peas until bright green and tender.',
            'Soak cashews in hot water and blend with ginger and green chilies into an ultra-smooth white paste.',
            'Heat ghee in a pan, crackle cardamom pods and cumin seeds. Add the cashew paste and cook on low heat for 5 minutes.',
            'Add the sautéed methi leaves, tender green peas, salt, and half cup of warm water. Simmer for 5 minutes.',
            'Fold in fresh heavy cream and a pinch of sugar; warm through gently and serve with tandoori roti.',
          ],
        ),

        // 10. Jeera Rice & Yellow Dal Tadka
        Recipe(
          id: 'rec_jeera_rice_dal',
          title: 'Jeera Rice & Yellow Dal Tadka',
          description:
              'Fragrant aged basmati rice scented with crackled cumin seeds and desi ghee, accompanied by yellow moong dal tempered with ginger, hing, and dried red chilies.',
          category: 'Rice Special',
          imageUrl: 'assets/images/vegetable_biryani.png',
          prepTimeMinutes: 10,
          cookTimeMinutes: 20,
          difficulty: Difficulty.easy,
          servings: 4,
          calories: 410,
          tags: ['Pure Vegetarian', 'Comfort Meal', 'Quick Prep', 'Everyday Classic'],
          ingredients: [
            Ingredient(
              name: 'Aged Saffron Basmati Rice',
              amount: 350,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Yellow Moong Dal',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Pure Desi Ghee',
              amount: 3.5,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Cumin Seeds',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Vine Ripe Tomatoes',
              amount: 150,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Ginger Root',
              amount: 15,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Hing & Whole Red Chilies',
              amount: 1,
              unit: 'tsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'Cook washed basmati rice. In a pan, crackle 1.5 tbsp cumin seeds in ghee until nutty and fold through the warm rice.',
            'Pressure cook yellow moong dal with turmeric and salt until silky and smooth.',
            'Prepare the double tadka: Heat remaining ghee, crackle cumin seeds, dried red chilies, grated ginger, and chopped tomatoes.',
            'Stir in aromatic hing powder and red chili powder; pour sizzling over the cooked dal.',
            'Garnish with freshly plucked cilantro and serve with steaming cumin rice and papad.',
          ],
        ),

        // 11. Sattvic Indori Poha
        Recipe(
          id: 'rec_sattvic_poha',
          title: 'Sattvic Indori Poha',
          description:
              'Light, fluffy flattened rice flakes tempered with mustard seeds, curry leaves, green chilies, turmeric, crunchy roasted peanuts, and fresh lemon juice.',
          category: 'Breakfast & Snacks',
          imageUrl: 'assets/images/vegetable_biryani.png',
          prepTimeMinutes: 10,
          cookTimeMinutes: 10,
          difficulty: Difficulty.easy,
          servings: 3,
          calories: 290,
          tags: ['Pure Vegetarian', 'Quick Breakfast', 'Light & Fluffy', 'Sattvic'],
          ingredients: [
            Ingredient(
              name: 'Thick Poha (Flattened Rice)',
              amount: 250,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Roasted Peanuts',
              amount: 50,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Mustard Seeds & Curry Leaves',
              amount: 1,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Fresh Ginger Root',
              amount: 10,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Green Chilies',
              amount: 2,
              unit: 'pcs',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Pure Desi Ghee',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Fresh Lemon & Cilantro',
              amount: 1,
              unit: 'pcs',
              category: IngredientCategory.produce,
            ),
          ],
          instructions: [
            'Rinse thick poha gently in a colander under running water for 30 seconds; drain completely and toss with turmeric and salt.',
            'Heat ghee in a pan, fry raw peanuts until crunchy and golden; remove and set aside.',
            'In the same pan, crackle mustard seeds, curry leaves, chopped green chilies, and grated ginger.',
            'Gently fold in the softened poha, cover with a lid, and steam on lowest heat for 3 minutes.',
            'Drizzle with fresh lemon juice, fold in roasted peanuts, and garnish with fresh cilantro.',
          ],
        ),

        // 12. Tandoori Paneer Tikka Skewers
        Recipe(
          id: 'rec_paneer_tikka',
          title: 'Tandoori Paneer Tikka Skewers',
          description:
              'Artisanal paneer cubes, bell peppers, and tomatoes marinated in hung yogurt, roasted gram flour, Kashmiri chili, and ajwain, seared until smoky and charred.',
          category: 'Breakfast & Snacks',
          imageUrl: 'assets/images/shahi_paneer.png',
          prepTimeMinutes: 20,
          cookTimeMinutes: 15,
          difficulty: Difficulty.medium,
          servings: 4,
          calories: 380,
          tags: ['Pure Vegetarian', 'Tandoori Appetizer', 'High Protein', 'Smoky'],
          ingredients: [
            Ingredient(
              name: 'Fresh Malai Paneer',
              amount: 400,
              unit: 'g',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Bell Peppers (Capsicum)',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Thick Hung Yogurt',
              amount: 150,
              unit: 'g',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Roasted Gram Flour (Besan)',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Mustard Oil & Desi Ghee',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Ajwain & Kasuri Methi',
              amount: 1,
              unit: 'tsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Fresh Lemon & Chaat Masala',
              amount: 1,
              unit: 'tsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'In a bowl, mix hung yogurt, roasted besan, hot mustard oil, Kashmiri chili, crushed ajwain, kasuri methi, and salt into a thick marinade.',
            'Gently coat thick paneer cubes and bell pepper squares in the marinade; rest for 20 minutes.',
            'Thread paneer and bell peppers onto skewers.',
            'Grill on a hot cast iron skillet or oven at 220°C for 12-15 minutes, basting with ghee until edges are deliciously charred.',
            'Dust generously with chaat masala, lemon juice, and serve hot with mint chutney.',
          ],
        ),

        // 13. Artisan Neapolitan Margherita Pizza
        Recipe(
          id: 'rec_margherita_pizza',
          title: 'Artisan Neapolitan Margherita Pizza',
          description:
              'Hand-stretched slow-fermented crust blistered at high heat, topped with sweet San Marzano tomato puree, fresh buffalo mozzarella, extra virgin olive oil, and aromatic basil.',
          category: 'Global Delights',
          imageUrl: 'assets/images/margherita_pizza.png',
          prepTimeMinutes: 20,
          cookTimeMinutes: 12,
          difficulty: Difficulty.medium,
          servings: 3,
          calories: 560,
          tags: ['Pure Vegetarian', 'Wood Fired', 'Italian Classic'],
          ingredients: [
            Ingredient(
              name: 'Pizza Dough',
              amount: 400,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'San Marzano Tomato Puree',
              amount: 250,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Mozzarella Cheese',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Fresh Basil Leaves',
              amount: 15,
              unit: 'leaves',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Extra Virgin Olive Oil',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.pantry,
            ),
          ],
          instructions: [
            'Preheat oven to maximum heat with a baking stone inside for at least 40 minutes.',
            'Stretch dough onto parchment into a 12-inch circular base with airy crust rims.',
            'Ladle sweet tomato sauce evenly, leaving a 1-inch border along the perimeter.',
            'Scatter torn fresh mozzarella chunks and drizzle cold-pressed olive oil.',
            'Bake until crust is leopard-spotted and cheese is bubbling.',
            'Garnish with fresh sweet basil leaves immediately upon removing from oven.',
          ],
        ),

        // 14. Creamy Avocado Basil Pesto Pasta
        Recipe(
          id: 'rec_avocado_pesto',
          title: 'Creamy Avocado Basil Pesto Pasta',
          description:
              'Silky ripe avocado blended with fragrant sweet basil, toasted pine nuts, extra virgin olive oil, and lemon zest, tossed with al dente fusilli pasta.',
          category: 'Global Delights',
          imageUrl: 'assets/images/avocado_pasta.png',
          prepTimeMinutes: 10,
          cookTimeMinutes: 12,
          difficulty: Difficulty.easy,
          servings: 3,
          calories: 430,
          tags: ['Pure Vegetarian', 'Quick Dinner', 'Heart Healthy', 'Plant Powered'],
          ingredients: [
            Ingredient(
              name: 'Fusilli Pasta',
              amount: 300,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Ripe Hass Avocado',
              amount: 2,
              unit: 'pcs',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Basil Leaves',
              amount: 1,
              unit: 'cups',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Pine Nuts',
              amount: 35,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Extra Virgin Olive Oil',
              amount: 3,
              unit: 'tbsp',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Cherry Tomatoes',
              amount: 150,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
          ],
          instructions: [
            'Boil fusilli in salted water until al dente. Reserve 1/2 cup pasta cooking water.',
            'In a blender, combine avocado flesh, basil leaves, toasted pine nuts, olive oil, lemon juice, and sea salt.',
            'Pulse until rich and silky green, adding warm pasta water to achieve a luscious sauce.',
            'Toss warm pasta with avocado pesto immediately so the sauce clings beautifully.',
            'Garnish with sweet halved cherry tomatoes and cracked black pepper.',
          ],
        ),

        // 15. Crispy Ginger Teriyaki Tofu & Bok Choy
        Recipe(
          id: 'rec_teriyaki_tofu',
          title: 'Crispy Ginger Teriyaki Tofu & Bok Choy',
          description:
              'Crisp pan-seared organic firm tofu tossed in a savory ginger-tamari glaze, served over tender steamed baby bok choy and toasted sesame seeds.',
          category: 'Global Delights',
          imageUrl: 'assets/images/tofu_steaks.png',
          prepTimeMinutes: 15,
          cookTimeMinutes: 15,
          difficulty: Difficulty.medium,
          servings: 3,
          calories: 410,
          tags: ['Pure Vegetarian', 'High Protein', 'Glaze Master', 'Asian Feast'],
          ingredients: [
            Ingredient(
              name: 'Organic Firm Tofu',
              amount: 400,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Baby Bok Choy',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Ginger Root',
              amount: 25,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Tamari Soy Sauce',
              amount: 3,
              unit: 'tbsp',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Toasted Sesame Oil & Seeds',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'Press firm tofu between clean towels to extract excess moisture; cut into bite-sized cubes.',
            'Sear tofu cubes in oil in a skillet for 8-10 minutes until golden and crispy on all facets.',
            'Steam baby bok choy in a covered pan for 3 minutes until emerald and tender-crisp.',
            'Whisk soy sauce, fresh grated ginger, brown sugar, and sesame oil with 2 tbsp water.',
            'Pour glaze directly over tofu in the hot pan; toss vigorously until sticky and glossy.',
            'Serve warm over steamed jasmine rice with bok choy and toasted sesame seeds.',
          ],
        ),

        // 16. Surti Gujarati Undhiyu
        Recipe(
          id: 'rec_surti_undhiyu',
          title: 'Surti Gujarati Undhiyu',
          description:
              'Celebrated Gujarati winter specialty prepared with baby eggplants, purple yam (kand), sweet potatoes, and fenugreek muthia dumplings slow-cooked in a fragrant green coconut and fresh herb marinade.',
          category: 'Curries & Dal',
          imageUrl: 'assets/images/vegetable_biryani.png',
          prepTimeMinutes: 25,
          cookTimeMinutes: 35,
          difficulty: Difficulty.hard,
          servings: 4,
          calories: 420,
          tags: ['Pure Vegetarian', 'Gujarati Heritage', 'Sattvic Feast', 'Winter Classic'],
          ingredients: [
            Ingredient(
              name: 'Surti Papdi (Flat Beans)',
              amount: 250,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Purple Yam & Sweet Potato',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Baby Eggplants & Potatoes',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Fenugreek (Methi Muthia)',
              amount: 150,
              unit: 'g',
              category: IngredientCategory.proteins,
            ),
            Ingredient(
              name: 'Fresh Grated Coconut',
              amount: 100,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Cold Pressed Peanut Oil',
              amount: 4,
              unit: 'tbsp',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Fresh Ginger & Green Chilli Paste',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Carom Seeds (Ajwain) & White Sesame',
              amount: 2,
              unit: 'tsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'Prepare Methi Muthia dumplings by mixing gram flour, chopped fresh fenugreek, carom seeds, ginger, and shallow-frying until golden.',
            'Grind fresh coconut, coriander leaves, green chillies, ginger, and sesame seeds into an aromatic green stuffing paste.',
            'Slit baby brinjals and potatoes; stuff generously with the fresh coconut masala.',
            'In a heavy-bottomed clay or copper vessel, heat oil, crackle ajwain, layer root vegetables, flat beans, and stuffed vegetables.',
            'Cover and cook on gentle flame for 30 minutes until vegetables turn buttery tender; fold in methi muthias in the final 5 minutes.',
            'Garnish with grated coconut and fresh cilantro; serve hot with golden puris and mango shrikhand.',
          ],
        ),

        // 17. Mumbai Pav Bhaji (Sattvic Style)
        Recipe(
          id: 'rec_mumbai_pav_bhaji',
          title: 'Mumbai Pav Bhaji (Sattvic Style)',
          description:
              'Iconic street food favorite crafted with slow-simmered potatoes, tender green peas, cauliflower, and vine tomatoes mashed on a massive iron tawa with rich butter and aromatic spices. Pure vegetarian comfort.',
          category: 'Breakfast & Snacks',
          imageUrl: 'assets/images/dal_makhani.png',
          prepTimeMinutes: 15,
          cookTimeMinutes: 20,
          difficulty: Difficulty.medium,
          servings: 4,
          calories: 460,
          tags: ['Street Food Classic', 'Pure Vegetarian', 'Family Favorite', 'Butter Rich'],
          ingredients: [
            Ingredient(
              name: 'Boiled Potatoes & Cauliflower',
              amount: 400,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Green Peas',
              amount: 150,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Vine Ripe Tomatoes',
              amount: 400,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Amul Table Butter',
              amount: 60,
              unit: 'g',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Fresh Ginger Root',
              amount: 25,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Artisan Pav Buns',
              amount: 8,
              unit: 'pcs',
              category: IngredientCategory.bakery,
            ),
            Ingredient(
              name: 'Special Pav Bhaji Masala',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Fresh Coriander & Lime',
              amount: 1,
              unit: 'bunch',
              category: IngredientCategory.produce,
            ),
          ],
          instructions: [
            'Boil potatoes, cauliflower florets, and green peas until completely tender, then mash smoothly with a potato masher.',
            'Melt pure butter on a large tawa, add grated ginger and slit green chillies, then sauté tomato puree until fragrant and rich.',
            'Incorporate mashed vegetables with pav bhaji masala, Kashmiri red chilli powder, and a splash of vegetable stock.',
            'Simmer vigorously while continuously mashing with a tawa masher for 10 minutes until silky and glistening.',
            'Toast fluffy pav buns in liberal amounts of butter and pav bhaji masala on the hot tawa.',
            'Serve piping hot with a melting pat of butter, fresh cilantro, and juicy lemon wedges.',
          ],
        ),

        // 18. South Indian Bisi Bele Bath
        Recipe(
          id: 'rec_bisi_bele_bath',
          title: 'South Indian Bisi Bele Bath',
          description:
              'Hearty Karnataka one-pot royal comfort dish combining short-grain rice, toor dal, mixed garden vegetables, and a stone-ground aromatic spice blend with tamarind and ghee-roasted cashews.',
          category: 'Rice Special',
          imageUrl: 'assets/images/vegetable_biryani.png',
          prepTimeMinutes: 15,
          cookTimeMinutes: 25,
          difficulty: Difficulty.medium,
          servings: 4,
          calories: 390,
          tags: ['South Indian Special', 'Pure Vegetarian', 'Protein Rich', 'One Pot Meal'],
          ingredients: [
            Ingredient(
              name: 'Sona Masoori Rice',
              amount: 250,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Organic Toor Dal',
              amount: 150,
              unit: 'g',
              category: IngredientCategory.proteins,
            ),
            Ingredient(
              name: 'Diced Carrots, Beans & Drumstick',
              amount: 250,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Tamarind Pulp',
              amount: 3,
              unit: 'tbsp',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Pure Desi Ghee',
              amount: 3,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Raw Cashew Nuts',
              amount: 50,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Bisi Bele Bath Masala (Cinnamon, Maratti Moggu)',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Mustard Seeds & Curry Leaves',
              amount: 1,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'Pressure cook rice and toor dal together with turmeric and 4 cups of water until soft and well melded.',
            'Cook chopped vegetables in water with a pinch of salt until tender-crisp.',
            'Add tamarind extract, bisi bele bath spice blend, and jaggery to the cooked vegetables and bring to a rolling boil.',
            'Blend in the mashed rice-dal mixture; simmer on low heat for 8 minutes to let the flavours saturate each grain.',
            'Temper mustard seeds, curry leaves, and whole cashews in hot desi ghee until golden and aromatic.',
            'Pour tempering over the steaming bath; serve hot with crispy potato chips or refreshing boondi raita.',
          ],
        ),

        // 19. Amritsari Chole & Fluffy Bhature
        Recipe(
          id: 'rec_amritsari_chole',
          title: 'Amritsari Chole & Fluffy Bhature',
          description:
              'Dark, rich Punjabi kabuli chickpeas slow-steeped with tea decoction, dried pomegranate seeds (anardana), dry ginger, and black cardamom, accompanied by crispy puffed golden bhature.',
          category: 'North Indian',
          imageUrl: 'assets/images/white_bean_skillet.png',
          prepTimeMinutes: 20,
          cookTimeMinutes: 30,
          difficulty: Difficulty.hard,
          servings: 4,
          calories: 520,
          tags: ['North Indian Feast', 'Pure Vegetarian', 'Protein Power', 'Sunday Special'],
          ingredients: [
            Ingredient(
              name: 'Kabuli Chickpeas (Chole)',
              amount: 350,
              unit: 'g',
              category: IngredientCategory.proteins,
            ),
            Ingredient(
              name: 'Vine Ripe Tomatoes',
              amount: 300,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Ginger Root (Julienned)',
              amount: 30,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Pure Desi Ghee',
              amount: 3,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Dried Pomegranate Seeds (Anardana)',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Whole Spices (Cumin, Black Cardamom, Cloves)',
              amount: 1,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Refined Wheat Flour (for Bhature)',
              amount: 300,
              unit: 'g',
              category: IngredientCategory.bakery,
            ),
            Ingredient(
              name: 'Fresh Yogurt (whisked)',
              amount: 80,
              unit: 'g',
              category: IngredientCategory.dairy,
            ),
          ],
          instructions: [
            'Soak chickpeas overnight; boil with tea pouch, black cardamom, bay leaf, and rock salt until melt-in-mouth tender.',
            'Knead flour with yogurt, a pinch of semolina, baking soda, and warm water; rest dough for 2 hours for bhature.',
            'In ghee, crackle cumin seeds, sauté grated ginger, anardana powder, coriander powder, and tomato puree until oil separates.',
            'Add boiled chickpeas with cooking liquor; crush a ladleful of chickpeas against the pan wall to create thick gravy.',
            'Roll rested dough discs and slide into smoking hot oil; bathe with hot oil until they puff like golden balloons.',
            'Garnish chole with ginger juliennes and green chillies; serve immediately with piping hot bhature and lemon.',
          ],
        ),

        // 20. Hyderabadi Mirchi Ka Salan (Sattvic Version)
        Recipe(
          id: 'rec_mirchi_salan',
          title: 'Hyderabadi Mirchi Ka Salan (Sattvic Version)',
          description:
              'Plump Bhavnagri mild green peppers shallow-fried and simmered in a velvety sauce made from roasted peanuts, sesame seeds, fresh coconut, tamarind, and ginger. A royal Nizami delight.',
          category: 'Curries & Dal',
          imageUrl: 'assets/images/shahi_paneer.png',
          prepTimeMinutes: 15,
          cookTimeMinutes: 20,
          difficulty: Difficulty.medium,
          servings: 4,
          calories: 330,
          tags: ['Royal Nizami', 'Pure Vegetarian', 'Aromatic Rich', 'Biryani Side'],
          ingredients: [
            Ingredient(
              name: 'Bhavnagri Mild Peppers',
              amount: 8,
              unit: 'pcs',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Roasted Peanuts',
              amount: 80,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'White Sesame Seeds',
              amount: 3,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Fresh Grated Coconut',
              amount: 80,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Tamarind Pulp',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Fresh Ginger Root',
              amount: 20,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Pure Desi Ghee',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Mustard Seeds & Fenugreek Seeds',
              amount: 1,
              unit: 'tsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'Dry roast peanuts, sesame seeds, and grated coconut until golden; blend with fresh ginger into a fine, luscious paste.',
            'Slit Bhavnagri chillies lengthwise (deseed if desired); shallow-fry in hot oil until blistered and tender.',
            'Heat ghee, crackle mustard seeds, methi seeds, and curry leaves.',
            'Pour in the blended nut-seed paste and sauté on medium heat until fragrant and ghee begins to separate.',
            'Stir in tamarind pulp, turmeric, cumin powder, and 1.5 cups water; simmer into a smooth, glossy curry.',
            'Add the fried chillies, cover and simmer gently for 6 minutes before pairing with Dum Biryani or parathas.',
          ],
        ),

        // 21. Kesari Kesar Pista Mango Shrikhand
        Recipe(
          id: 'rec_kesar_mango_shrikhand',
          title: 'Kesari Kesar Pista Mango Shrikhand',
          description:
              'Silken, thick strained yogurt whipped with royal Kashmiri saffron strands, green cardamom powder, roasted Iranian pistachios, and pure Alphonso mango puree. Chilled dessert perfection.',
          category: 'Breakfast & Snacks',
          imageUrl: 'assets/images/shahi_paneer.png',
          prepTimeMinutes: 15,
          cookTimeMinutes: 0,
          difficulty: Difficulty.easy,
          servings: 4,
          calories: 280,
          tags: ['Royal Dessert', 'Pure Vegetarian', 'Sweet Indulgence', 'Sattvic'],
          ingredients: [
            Ingredient(
              name: 'Thick Hung Curd (Chakka)',
              amount: 500,
              unit: 'g',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Pure Alphonso Mango Pulp',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Powdered Cane Sugar',
              amount: 100,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Kashmiri Saffron (Kesar)',
              amount: 1,
              unit: 'g',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Roasted Pistachios & Almonds',
              amount: 40,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Green Cardamom Powder',
              amount: 1,
              unit: 'tsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'Hang fresh curd in muslin cloth for 6-8 hours in refrigerator until whey drains completely, yielding dense chakka.',
            'Dissolve saffron strands in 2 teaspoons of warm milk; let steep for 15 minutes to release deep gold color and perfume.',
            'In a wide bowl, whisk chakka and powdered sugar with a wire whisk until glossy, velvety, and completely lump-free.',
            'Fold in Alphonso mango puree, saffron elixir, and freshly ground cardamom powder until uniformly blended.',
            'Transfer into traditional clay bowls (matkas); chill in the refrigerator for at least 2 hours.',
            'Crown with toasted slivered pistachios and crushed dried rose petals before serving cold.',
          ],
        ),

        // 22. Delhi Style Butter Chicken (Murgh Makhani)
        Recipe(
          id: 'rec_butter_chicken',
          title: 'Delhi Style Butter Chicken (Murgh Makhani)',
          description:
              'Tender tandoori-roasted chicken tikka simmered in a velvety makhani sauce crafted with ripe vine tomatoes, golden sautéed onions, generous crushed fresh garlic, pure butter, and aromatic kasuri methi.',
          category: 'North Indian',
          imageUrl: 'assets/images/tuscan_chicken.png',
          prepTimeMinutes: 20,
          cookTimeMinutes: 25,
          difficulty: Difficulty.medium,
          servings: 4,
          calories: 580,
          isVegetarian: false,
          tags: ['Non-Veg Classic', 'Butter Chicken', 'Garlic & Onion Rich', 'North Indian Delight'],
          ingredients: [
            Ingredient(
              name: 'Boneless Chicken Thighs (Tikka)',
              amount: 500,
              unit: 'g',
              category: IngredientCategory.proteins,
            ),
            Ingredient(
              name: 'Fresh Garlic Cloves (Crushed)',
              amount: 40,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Red Onions (Finely Chopped)',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Vine Ripe Tomatoes',
              amount: 500,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Amul Butter & Heavy Cream',
              amount: 60,
              unit: 'g',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Pure Desi Ghee',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Kasuri Methi & Garam Masala',
              amount: 1,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Fresh Ginger Paste',
              amount: 25,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
          ],
          instructions: [
            'Marinate chicken pieces with yogurt, kashmiri chili powder, ginger-garlic paste, and lemon juice for 1 hour; sear on high flame until charred.',
            'In a heavy kadai, melt butter with ghee; sauté chopped onions until translucent and golden.',
            'Add crushed garlic and ginger paste; stir continuously for 2 minutes until rich aroma releases.',
            'Pour in fresh tomato puree and cashew paste; simmer until butter leaves the sides.',
            'Fold in the roasted chicken tikka pieces, kasuri methi, garam masala, and fresh heavy cream.',
            'Simmer gently on low flame for 6 minutes; serve hot with garlic butter naan or basmati rice.',
          ],
        ),

        // 23. Kashmiri Mutton Rogan Josh
        Recipe(
          id: 'rec_mutton_rogan_josh',
          title: 'Kashmiri Mutton Rogan Josh',
          description:
              'Succulent bone-in mutton slow-cooked with browned onion paste (birista), crushed garlic cloves, vibrant Kashmiri deggi mirch, fennel, and whole warm spices until meltingly tender.',
          category: 'North Indian',
          imageUrl: 'assets/images/dal_makhani.png',
          prepTimeMinutes: 20,
          cookTimeMinutes: 45,
          difficulty: Difficulty.hard,
          servings: 4,
          calories: 620,
          isVegetarian: false,
          tags: ['Mutton Royal', 'Kashmiri Heritage', 'Non-Veg Special', 'Slow Cooked'],
          ingredients: [
            Ingredient(
              name: 'Bone-in Tender Mutton (Goat Meat)',
              amount: 600,
              unit: 'g',
              category: IngredientCategory.proteins,
            ),
            Ingredient(
              name: 'Browned Sliced Onions (Birista)',
              amount: 250,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Garlic Cloves',
              amount: 30,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Whisked Yogurt',
              amount: 150,
              unit: 'g',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Kashmiri Red Chilli Powder',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Fennel Powder & Dry Ginger (Saunth)',
              amount: 1,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Pure Mustard Oil & Desi Ghee',
              amount: 3,
              unit: 'tbsp',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Whole Spices (Black Cardamom, Cloves, Cinnamon)',
              amount: 1,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'Heat mustard oil to smoking point, cool slightly, then crackle black cardamom, cloves, cinnamon, and bay leaf.',
            'Add tender mutton pieces and sear on high heat until beautifully browned on all facets.',
            'Stir in crushed garlic paste and sauté for 2 minutes until aromatic.',
            'Lower flame; add whisked yogurt mixed with fennel powder, dry ginger, and Kashmiri chili powder.',
            'Blend browned onions into a smooth paste and fold into the curry with 1.5 cups of warm water.',
            'Cover tightly and slow-cook on low flame for 45 minutes until the meat is fork-tender and rich rogan oil surfaces.',
          ],
        ),

        // 24. Hyderabadi Chicken Dum Biryani
        Recipe(
          id: 'rec_hyderabadi_chicken_biryani',
          title: 'Hyderabadi Chicken Dum Biryani',
          description:
              'Kacchi yakhni layered royal biryani where chicken is marinated in yogurt, crispy fried onions (birista), crushed garlic, ginger, and mint, then steam-cooked on dum with saffron basmati rice.',
          category: 'Rice Special',
          imageUrl: 'assets/images/vegetable_biryani.png',
          prepTimeMinutes: 30,
          cookTimeMinutes: 40,
          difficulty: Difficulty.hard,
          servings: 6,
          calories: 640,
          isVegetarian: false,
          tags: ['Hyderabadi Royal', 'Dum Biryani', 'Non-Veg Feast', 'Onion & Garlic Rich'],
          ingredients: [
            Ingredient(
              name: 'Fresh Bone-in Chicken',
              amount: 750,
              unit: 'g',
              category: IngredientCategory.proteins,
            ),
            Ingredient(
              name: 'Aged Saffron Basmati Rice',
              amount: 500,
              unit: 'g',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Golden Fried Sliced Onions (Birista)',
              amount: 300,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Garlic Cloves (Minced)',
              amount: 35,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Ginger & Green Chillies',
              amount: 30,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Mint & Cilantro Leaves',
              amount: 2,
              unit: 'bunches',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Thick Yogurt (Dahi)',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Pure Desi Ghee & Saffron Milk',
              amount: 4,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
          ],
          instructions: [
            'Marinate chicken pieces with yogurt, fried onions (birista), crushed garlic, ginger paste, mint, garam masala, and lemon juice for at least 2 hours.',
            'Parboil soaked basmati rice in salted water with whole spices until 70% cooked; drain immediately.',
            'Spread marinated chicken evenly at the base of a heavy handi; layer parboiled fragrant rice on top.',
            'Drizzle infused saffron milk, melted desi ghee, remaining crispy fried onions, and fresh chopped mint leaves.',
            'Seal the handi rim with wheat dough and heavy lid; cook on high flame for 10 minutes, then low flame on a tawa for 30 minutes.',
            'Rest for 10 minutes before gently cutting through layers with a flat spoon; serve with mirchi ka salan and onion raita.',
          ],
        ),

        // 25. Goan Fish Curry (Surmai Curry)
        Recipe(
          id: 'rec_goan_fish_curry',
          title: 'Goan Fish Curry (Surmai Curry)',
          description:
              'Fresh kingfish (surmai) steaks gently poached in a fiery, tangy coastal Goan curry of freshly ground coconut, dried red chillies, garlic cloves, onions, and sour kokum petals.',
          category: 'South Indian',
          imageUrl: 'assets/images/lemon_salmon.png',
          prepTimeMinutes: 15,
          cookTimeMinutes: 20,
          difficulty: Difficulty.medium,
          servings: 4,
          calories: 410,
          isVegetarian: false,
          tags: ['Coastal Seafood', 'Goan Cuisine', 'Fish Special', 'Coconut & Garlic'],
          ingredients: [
            Ingredient(
              name: 'Fresh Kingfish (Surmai) Steaks',
              amount: 500,
              unit: 'g',
              category: IngredientCategory.proteins,
            ),
            Ingredient(
              name: 'Fresh Grated Coconut',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Red Onions (Thinly Sliced)',
              amount: 150,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Garlic Cloves',
              amount: 25,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Kashmiri Dried Red Chillies',
              amount: 8,
              unit: 'pcs',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Kokum Petals & Tamarind',
              amount: 6,
              unit: 'pcs',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Cold-Pressed Coconut Oil',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Coriander Seeds & Cumin',
              amount: 1,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'Rub kingfish steaks with turmeric, salt, and lime juice; rest for 15 minutes.',
            'Grind grated coconut, dried red chilies, garlic cloves, coriander seeds, and cumin with water into a silken orange paste.',
            'Heat coconut oil in an earthenware pot (chatti); sauté sliced onions and green chillies until soft.',
            'Pour in the ground coconut spice paste and kokum water; bring to a lively simmer for 8 minutes.',
            'Gently slide in kingfish steaks; simmer uncovered on gentle flame for 6 minutes without stirring with a spoon (swirl pot).',
            'Serve piping hot with red boiled rice (ukda rice) and fried fish.',
          ],
        ),

        // 26. Dhaba Style Tariwala Egg Curry
        Recipe(
          id: 'rec_dhaba_egg_curry',
          title: 'Dhaba Style Tariwala Egg Curry',
          description:
              'Hard-boiled eggs blistered golden in turmeric oil, bathed in a rustic highway dhaba style gravy made with caramelized onions, minced garlic, vine tomatoes, and robust roasted spices.',
          category: 'Curries & Dal',
          imageUrl: 'assets/images/shahi_paneer.png',
          prepTimeMinutes: 10,
          cookTimeMinutes: 20,
          difficulty: Difficulty.easy,
          servings: 4,
          calories: 380,
          isVegetarian: false,
          tags: ['Dhaba Special', 'Egg Curry', 'High Protein', 'Onion Garlic Gravy'],
          ingredients: [
            Ingredient(
              name: 'Farm Fresh Eggs (Hard-Boiled)',
              amount: 6,
              unit: 'pcs',
              category: IngredientCategory.proteins,
            ),
            Ingredient(
              name: 'Yellow Onions (Finely Chopped)',
              amount: 250,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Crushed Fresh Garlic',
              amount: 25,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Vine Ripe Tomatoes (Pureed)',
              amount: 300,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Ginger Paste',
              amount: 20,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Mustard Oil & Desi Ghee',
              amount: 3,
              unit: 'tbsp',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Kasuri Methi & Garam Masala',
              amount: 1,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Fresh Coriander Leaves',
              amount: 1,
              unit: 'bunch',
              category: IngredientCategory.produce,
            ),
          ],
          instructions: [
            'Make shallow slits on boiled eggs; shallow fry in a tablespoon of hot oil with turmeric and chili powder until blistered golden.',
            'Heat mustard oil, crackle cumin seeds, bay leaf, and add finely chopped onions; sauté until deep brown.',
            'Add crushed garlic and ginger paste; cook for 2 minutes until the raw edge subsides.',
            'Stir in tomato puree, coriander powder, cumin powder, and turmeric; cook until oil glints on surface.',
            'Pour in 1.5 cups of warm water to create a soul-satisfying dhaba-style tari (broth); bring to rolling boil.',
            'Add the golden eggs and crushed kasuri methi; simmer for 5 minutes and garnish with fresh cilantro.',
          ],
        ),

        // 27. Kolhapuri Sukka Chicken
        Recipe(
          id: 'rec_kolhapuri_sukka_chicken',
          title: 'Kolhapuri Sukka Chicken',
          description:
              'Intensely flavored Maharashtrian dry chicken preparation coated in a dark roasted coconut, caramelized onion, garlic, and Kolhapuri kanda-lasun masala paste with curry leaves.',
          category: 'North Indian',
          imageUrl: 'assets/images/tuscan_chicken.png',
          prepTimeMinutes: 15,
          cookTimeMinutes: 25,
          difficulty: Difficulty.medium,
          servings: 4,
          calories: 510,
          isVegetarian: false,
          tags: ['Maharashtrian', 'Kolhapuri Spicy', 'Dry Roast', 'Onion Garlic Rich'],
          ingredients: [
            Ingredient(
              name: 'Bone-in Chicken Pieces',
              amount: 600,
              unit: 'g',
              category: IngredientCategory.proteins,
            ),
            Ingredient(
              name: 'Roasted Sliced Onions',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Garlic Cloves',
              amount: 30,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Dry Desiccated Coconut (Khobri)',
              amount: 80,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Kolhapuri Kanda-Lasun Masala',
              amount: 2,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Fresh Ginger',
              amount: 20,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Peanut Oil',
              amount: 3,
              unit: 'tbsp',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Curry Leaves & White Sesame',
              amount: 1,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'Roast sliced onions, dry coconut, sesame seeds, garlic, and ginger in a pan until dark brown; grind into thick vatana paste.',
            'Heat peanut oil in a kadai, add curry leaves and chicken pieces with turmeric and salt; sauté on high heat for 6 minutes.',
            'Add Kolhapuri masala and the roasted onion-coconut paste, tossing until every piece is richly coated.',
            'Sprinkle half a cup of warm water, cover and cook on medium flame for 15 minutes until chicken is tender.',
            'Remove lid and stir-fry vigorously on high flame until moisture evaporates into a thick, clinging masala coat.',
            'Garnish with chopped cilantro; serve hot with bhakri, chapati, or steamed rice with tambda rassa.',
          ],
        ),

        // 28. Malabar Prawns Roast (Chemmeen Roast)
        Recipe(
          id: 'rec_malabar_prawns_roast',
          title: 'Malabar Prawns Roast (Chemmeen Roast)',
          description:
              'Succulent juicy tiger prawns pan-roasted with sliced shallots, garlic slivers, curry leaves, crushed black pepper, and tangy tomato slices in pure cold-pressed coconut oil.',
          category: 'South Indian',
          imageUrl: 'assets/images/lemon_salmon.png',
          prepTimeMinutes: 15,
          cookTimeMinutes: 15,
          difficulty: Difficulty.easy,
          servings: 4,
          calories: 350,
          isVegetarian: false,
          tags: ['Kerala Special', 'Seafood Delight', 'Prawns Roast', 'Shallots & Garlic'],
          ingredients: [
            Ingredient(
              name: 'Fresh Tiger Prawns (Cleaned)',
              amount: 450,
              unit: 'g',
              category: IngredientCategory.proteins,
            ),
            Ingredient(
              name: 'Small Shallots / Red Onions (Sliced)',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Garlic Slivers',
              amount: 25,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Curry Leaves',
              amount: 2,
              unit: 'sprigs',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Ginger Paste',
              amount: 20,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Cold-Pressed Coconut Oil',
              amount: 3,
              unit: 'tbsp',
              category: IngredientCategory.pantry,
            ),
            Ingredient(
              name: 'Crushed Black Peppercorns',
              amount: 1,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
            Ingredient(
              name: 'Tomato Slices',
              amount: 150,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
          ],
          instructions: [
            'Marinate cleaned prawns with chili powder, turmeric, black pepper, lemon juice, and salt for 10 minutes.',
            'Heat coconut oil in a pan; sear prawns quickly for 2 minutes on each side; transfer to a plate.',
            'In the same fragrant pan oil, crackle mustard seeds, plenty of curry leaves, garlic slivers, and sliced shallots.',
            'Sauté onions on medium flame until golden brown and sweet; add ginger paste, green chillies, and sliced tomatoes.',
            'Cook until tomatoes soften into a jammy consistency; return the seared prawns along with freshly crushed black pepper.',
            'Toss together over high flame for 3 minutes until the dark spiced masala clings tightly to the juicy prawns.',
          ],
        ),

        // 29. Railway Mutton Keema Matar
        Recipe(
          id: 'rec_mutton_keema_matar',
          title: 'Railway Mutton Keema Matar',
          description:
              'Coarsely ground spiced mutton mince simmered with sweet green peas, caramelized onions, minced garlic, ginger, and whole garam masala. A timeless colonial Indian rail journey classic.',
          category: 'Curries & Dal',
          imageUrl: 'assets/images/white_bean_skillet.png',
          prepTimeMinutes: 15,
          cookTimeMinutes: 25,
          difficulty: Difficulty.medium,
          servings: 4,
          calories: 530,
          isVegetarian: false,
          tags: ['Classic Keema', 'Mutton Special', 'Onion Garlic Base', 'Comfort Dish'],
          ingredients: [
            Ingredient(
              name: 'Minced Mutton / Lamb (Keema)',
              amount: 500,
              unit: 'g',
              category: IngredientCategory.proteins,
            ),
            Ingredient(
              name: 'Sweet Green Peas',
              amount: 150,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Red Onions (Finely Chopped)',
              amount: 250,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Garlic (Minced)',
              amount: 30,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Fresh Ginger (Minced)',
              amount: 20,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Vine Ripe Tomatoes',
              amount: 200,
              unit: 'g',
              category: IngredientCategory.produce,
            ),
            Ingredient(
              name: 'Pure Desi Ghee & Oil',
              amount: 3,
              unit: 'tbsp',
              category: IngredientCategory.dairy,
            ),
            Ingredient(
              name: 'Garam Masala & Bay Leaves',
              amount: 1,
              unit: 'tbsp',
              category: IngredientCategory.spices,
            ),
          ],
          instructions: [
            'Heat ghee and oil in a deep kadai; crackle bay leaves, cinnamon stick, black cardamom, and cloves.',
            'Add finely chopped onions and sauté until dark reddish-brown; stir in minced garlic and ginger.',
            'Add the minced mutton (keema); break up lumps with a spatula and fry vigorously on high heat for 8 minutes until browned.',
            'Add coriander powder, red chili powder, turmeric, and pureed tomatoes; cook until fat glistens.',
            'Stir in green peas and 1 cup of warm stock or water; cover and simmer gently for 15 minutes.',
            'Finish with robust garam masala, slit green chillies, and a squeeze of fresh lime; serve with warm pav or buttered parathas.',
          ],
        ),
      ];

  /// Initial sample weekly meal plan covering the week with diverse Sattvic vegetarian meals.
  static WeeklyMealPlan get initialMealPlan {
    final recipes = initialRecipes;
    return WeeklyMealPlan(
      entries: [
        MealPlanEntry(
          id: 'initial_mon_dinner',
          day: DayOfWeek.monday,
          slot: MealSlot.dinner,
          recipe: recipes[0], // Shahi Paneer Butter Masala
        ),
        MealPlanEntry(
          id: 'initial_tue_dinner',
          day: DayOfWeek.tuesday,
          slot: MealSlot.dinner,
          recipe: recipes[3], // Royal Vegetable Dum Biryani
        ),
        MealPlanEntry(
          id: 'initial_wed_dinner',
          day: DayOfWeek.wednesday,
          slot: MealSlot.dinner,
          recipe: recipes[2], // Slow-Cooked Dal Makhani
        ),
        MealPlanEntry(
          id: 'initial_thu_lunch',
          day: DayOfWeek.thursday,
          slot: MealSlot.lunch,
          recipe: recipes[5], // South Indian Sambhar
        ),
        MealPlanEntry(
          id: 'initial_fri_dinner',
          day: DayOfWeek.friday,
          slot: MealSlot.dinner,
          recipe: recipes[1], // Creamy Palak Paneer
        ),
        MealPlanEntry(
          id: 'initial_sat_dinner',
          day: DayOfWeek.saturday,
          slot: MealSlot.dinner,
          recipe: recipes[4], // Banarasi Dum Aloo
        ),
        MealPlanEntry(
          id: 'initial_sun_lunch',
          day: DayOfWeek.sunday,
          slot: MealSlot.lunch,
          recipe: recipes[9], // Jeera Rice & Dal Tadka
        ),
      ],
    );
  }
}
