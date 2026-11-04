.class public Landroidx/databinding/adapters/TimePickerBindingAdapter;
.super Ljava/lang/Object;
.source "TimePickerBindingAdapter.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getHour(Landroid/widget/TimePicker;)I
    .locals 1
    .param p0, "view"    # Landroid/widget/TimePicker;

    .line 63
    nop

    .line 64
    invoke-virtual {p0}, Landroid/widget/TimePicker;->getHour()I

    move-result v0

    return v0
.end method

.method public static getMinute(Landroid/widget/TimePicker;)I
    .locals 1
    .param p0, "view"    # Landroid/widget/TimePicker;

    .line 78
    nop

    .line 79
    invoke-virtual {p0}, Landroid/widget/TimePicker;->getMinute()I

    move-result v0

    return v0
.end method

.method public static setHour(Landroid/widget/TimePicker;I)V
    .locals 1
    .param p0, "view"    # Landroid/widget/TimePicker;
    .param p1, "hour"    # I

    .line 36
    nop

    .line 37
    invoke-virtual {p0}, Landroid/widget/TimePicker;->getHour()I

    move-result v0

    if-eq v0, p1, :cond_0

    .line 38
    invoke-virtual {p0, p1}, Landroid/widget/TimePicker;->setHour(I)V

    .line 45
    :cond_0
    return-void
.end method

.method public static setListeners(Landroid/widget/TimePicker;Landroid/widget/TimePicker$OnTimeChangedListener;Landroidx/databinding/InverseBindingListener;Landroidx/databinding/InverseBindingListener;)V
    .locals 1
    .param p0, "view"    # Landroid/widget/TimePicker;
    .param p1, "listener"    # Landroid/widget/TimePicker$OnTimeChangedListener;
    .param p2, "hourChange"    # Landroidx/databinding/InverseBindingListener;
    .param p3, "minuteChange"    # Landroidx/databinding/InverseBindingListener;

    .line 95
    if-nez p2, :cond_0

    if-nez p3, :cond_0

    .line 96
    invoke-virtual {p0, p1}, Landroid/widget/TimePicker;->setOnTimeChangedListener(Landroid/widget/TimePicker$OnTimeChangedListener;)V

    goto :goto_0

    .line 98
    :cond_0
    new-instance v0, Landroidx/databinding/adapters/TimePickerBindingAdapter$1;

    invoke-direct {v0, p1, p2, p3}, Landroidx/databinding/adapters/TimePickerBindingAdapter$1;-><init>(Landroid/widget/TimePicker$OnTimeChangedListener;Landroidx/databinding/InverseBindingListener;Landroidx/databinding/InverseBindingListener;)V

    invoke-virtual {p0, v0}, Landroid/widget/TimePicker;->setOnTimeChangedListener(Landroid/widget/TimePicker$OnTimeChangedListener;)V

    .line 113
    :goto_0
    return-void
.end method

.method public static setMinute(Landroid/widget/TimePicker;I)V
    .locals 1
    .param p0, "view"    # Landroid/widget/TimePicker;
    .param p1, "minute"    # I

    .line 50
    nop

    .line 51
    invoke-virtual {p0}, Landroid/widget/TimePicker;->getMinute()I

    move-result v0

    if-eq v0, p1, :cond_0

    .line 52
    invoke-virtual {p0, p1}, Landroid/widget/TimePicker;->setMinute(I)V

    .line 59
    :cond_0
    return-void
.end method
