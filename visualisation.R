#!/usr/bin/env Rscript
#-------------------------------------------------------------------------------
# Name:         VisCount
# Purpose:      Count compositional data visualisation tool
# Version:      1.0
# Licence:      MIT Licence
# Author:       Jack Simpson
# Email:        jack@jacksimpson.co
# Created:      2015-02-12
#-------------------------------------------------------------------------------

visualise.data <- function(data, all_factors, log_min_value = 0){
    stopifnot(length(all_factors) < 4)
    
    list_unique_factors_per_col <- list()
    length_unique_factors_per_col <- list()
    all_factor_columns <- data[,all_factors]
    
    for (i in 1:length(all_factors)) {
        factor.col <- data[, all_factors[i]]
        list_unique_factors_per_col[[length(list_unique_factors_per_col)+1]] <- unique(factor.col)
        length_unique_factors_per_col[[length(length_unique_factors_per_col)+1]] <- length(unique(factor.col))
        data[,all_factors[i]] <- NULL # delete factor cols
    }
    
    if (log_min_value != 0){
        data[data == 0] <- log_min_value
        data <- log(data)
    }
    
    objects.to.plot                     <- colnames(data)
    max_value                       <- max(data, na.rm=TRUE)
    min_value                       <- min(data, na.rm=TRUE)
    range_value                                <- max_value - min_value
    min_take_range <- min_value - range_value / 2
    slider_steps = range_value / 100
    data             <- bind_cols(all_factor_columns, data)                             # replace factor columns
    
    if (length(all_factors) == 0)
    {
        graphic <- data %>% 
            ggvis(x = input_select(objects.to.plot, map = as.name, label = "X Axis", selected = objects.to.plot[[1]]), 
                  y = input_select(objects.to.plot, map = as.name, label = "Y Axis", selected = objects.to.plot[[2]])) %>%
            
            add_axis("x", title = "X Axis Variable", title_offset = 80) %>%
            add_axis("y", title = "Y Axis Variable", title_offset = 80) %>%
            
            scale_numeric("x", domain = input_slider(min_take_range, max_value, c(min_take_range, max_value), step = slider_steps, label = "X range")) %>%
            scale_numeric("y", domain = input_slider(min_take_range, max_value, c(min_take_range, max_value), step = slider_steps, label = "Y range")) %>%
            
            return (graphic)
    }
    
    else if (length(all_factors) == 1){
        
        uf1 <- unlist(list_unique_factors_per_col[[1]])
        
        graphic <- data %>% 
            ggvis(x = input_select(objects.to.plot, map = as.name, label = "X Axis", selected = objects.to.plot[[1]]), 
                  y = input_select(objects.to.plot, map = as.name, label = "Y Axis", selected = objects.to.plot[[2]])  ) %>%
            
            add_axis("x", title = "X Axis Variable", title_offset = 80) %>%
            add_axis("y", title = "Y Axis Variable", title_offset = 80) %>%
            
            filter(
                    data[[all_factors[[index_factors_by_num_unique[[1]]]]]] %in% eval(input_checkboxgroup(uf1, selected = uf1))
            ) %>%
            
            scale_ordinal("fill", domain=uf1) %>%
            
            layer_points(
                prop("fill", as.name(all_factors[index_factors_by_num_unique[[1]]])), size := input_slider(10, 500, value = 50, label = "Point Size"), 
                opacity := input_slider(0, 1, label = "Opacity")
            ) %>%
            
            scale_numeric("x", domain = input_slider(min_take_range, max_value, c(min_take_range, max_value), step = slider_steps, label = "X range")) %>%
            scale_numeric("y", domain = input_slider(min_take_range, max_value, c(min_take_range, max_value), step = slider_steps, label = "Y range")) %>%
            
            add_legend(scales = "fill", properties = legend_props(legend = list(y = 0))) %>%
            
            set_options(duration = 0) %>% view_dynamic()
        
        return (graphic)
        
    }
    
    else if (length(all_factors) == 2){
        
        sort_factors_by_num_unique <- sort(unlist(length_unique_factors_per_col), decreasing = T, index.return = T)
        index_factors_by_num_unique <- sort_factors_by_num_unique[[2]] #1 returns ordered list, 2 returns index
        uf1 <- list_unique_factors_per_col[[index_factors_by_num_unique[[1]]]]
        uf2 <- list_unique_factors_per_col[[index_factors_by_num_unique[[2]]]]
        
        graphic <- data %>% 
            ggvis(x = input_select(objects.to.plot, map = as.name, label = "X Axis", selected = objects.to.plot[[1]]), 
                  y = input_select(objects.to.plot, map = as.name, label = "Y Axis", selected = objects.to.plot[[2]])  ) %>%
            
            add_axis("x", title = "X Axis Variable", title_offset = 80) %>%
            add_axis("y", title = "Y Axis Variable", title_offset = 80) %>%
            
            filter(
                    data[[all_factors[[index_factors_by_num_unique[[2]]]]]] %in% eval(input_checkboxgroup(uf2, selected = uf2)) &
                    data[[all_factors[[index_factors_by_num_unique[[1]]]]]] %in% eval(input_checkboxgroup(uf1, selected = uf1))
                
            ) %>%
            
            scale_ordinal("fill", domain=uf1) %>%
            scale_ordinal("stroke", domain=uf2) %>%
            
            layer_points(
                prop("stroke", as.name(all_factors[index_factors_by_num_unique[[2]]])), strokeWidth := input_slider(0, 10, value = 1, label = "Stroke Width"),
                prop("fill", as.name(all_factors[index_factors_by_num_unique[[1]]])), size := input_slider(10, 500, value = 50, label = "Point Size"), 
                opacity := input_slider(0, 1, label = "Opacity")
            ) %>%
            
            scale_numeric("x", domain = input_slider(min_take_range, max_value, c(min_take_range, max_value), step = slider_steps, label = "X range")) %>%
            scale_numeric("y", domain = input_slider(min_take_range, max_value, c(min_take_range, max_value), step = slider_steps, label = "Y range")) %>%
            
            add_legend(scales = "stroke", properties = legend_props(legend = list(y = 0))) %>%
            add_legend(scales = "fill", properties = legend_props(legend = list(y = (length(uf2)*25)))) %>%
            
            set_options(duration = 0) %>% view_dynamic()
        
        return (graphic)

    }
    
    else if (length(all_factors) == 3){
        
        sort_factors_by_num_unique <- sort(unlist(length_unique_factors_per_col), decreasing = T, index.return = T)
        index_factors_by_num_unique <- sort_factors_by_num_unique[[2]] #1 returns ordered list, 2 returns index
        uf1 <- list_unique_factors_per_col[[index_factors_by_num_unique[[1]]]]
        uf2 <- list_unique_factors_per_col[[index_factors_by_num_unique[[2]]]]
        uf3 <- list_unique_factors_per_col[[index_factors_by_num_unique[[3]]]]
        
        if (length(uf3) > 6){
            print("WARNING: You have more than 6 levels in your shape factor - some shapes will be repeated!")
        }
        
        graphic <- data %>% 
            ggvis(x = input_select(objects.to.plot, map = as.name, label = "X Axis", selected = objects.to.plot[[1]]), 
                  y = input_select(objects.to.plot, map = as.name, label = "Y Axis", selected = objects.to.plot[[2]])  ) %>%

            add_axis("x", title = "X Axis Variable", title_offset = 80) %>%
            add_axis("y", title = "Y Axis Variable", title_offset = 80) %>%
            
            filter(
                data[[all_factors[[index_factors_by_num_unique[[3]]]]]] %in% eval(input_checkboxgroup(uf3, selected = uf3)) &
                data[[all_factors[[index_factors_by_num_unique[[2]]]]]] %in% eval(input_checkboxgroup(uf2, selected = uf2)) &
                data[[all_factors[[index_factors_by_num_unique[[1]]]]]] %in% eval(input_checkboxgroup(uf1, selected = uf1))
                       
            ) %>%
            
            scale_ordinal("fill", domain=uf1) %>%
            scale_ordinal("stroke", domain=uf2) %>%
            scale_ordinal("shape",domain=uf3) %>%
            
            layer_points(
                
                prop("shape", as.name(all_factors[index_factors_by_num_unique[[3]]])),
                prop("stroke", as.name(all_factors[index_factors_by_num_unique[[2]]])), strokeWidth := input_slider(0, 10, value = 1, label = "Stroke Width"),
                prop("fill", as.name(all_factors[index_factors_by_num_unique[[1]]])), size := input_slider(10, 500, value = 50, label = "Point Size"), 
                opacity := input_slider(0, 1, label = "Opacity")
            ) %>%
            
            scale_numeric("x", domain = input_slider(min_take_range, max_value, c(min_take_range, max_value), step = slider_steps, label = "X range")) %>%
            scale_numeric("y", domain = input_slider(min_take_range, max_value, c(min_take_range, max_value), step = slider_steps, label = "Y range")) %>%
            
            add_legend(scales = "shape", properties = legend_props(legend = list(y = 0))) %>%
            add_legend(scales = "stroke", properties = legend_props(legend = list(y = (length(uf3)*25)))) %>%
            add_legend(scales = "fill", properties = legend_props(legend = list(y = ((length(uf3)+length(uf2))*25)))) %>%
            
            set_options(duration = 0) %>% view_dynamic()
         
        return (graphic)
        
    }
    
}

install.load.packages <- function(packages){
    
    for (i in 1:length(packages)) {
        if (packages[i] %in% installed.packages()[,"Package"]){
            print(paste(packages[i], "is installed", sep=" "))
        }
        else{
            print(paste("Installing package:", packages[i], sep=" "))
            install.packages(packages[i])
        }
    }
    
    # load all packages
    lapply(packages, library, character.only = T)
}