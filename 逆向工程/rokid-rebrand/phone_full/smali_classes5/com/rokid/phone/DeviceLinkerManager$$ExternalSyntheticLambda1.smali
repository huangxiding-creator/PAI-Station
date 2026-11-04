.class public final synthetic Lcom/rokid/phone/DeviceLinkerManager$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# instance fields
.field public final synthetic f$0:Lcom/rokid/phone/DeviceLinkerManager;

.field public final synthetic f$1:Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

.field public final synthetic f$2:Lkotlin/jvm/functions/Function1;


# direct methods
.method public synthetic constructor <init>(Lcom/rokid/phone/DeviceLinkerManager;Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;Lkotlin/jvm/functions/Function1;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/phone/DeviceLinkerManager$$ExternalSyntheticLambda1;->f$0:Lcom/rokid/phone/DeviceLinkerManager;

    iput-object p2, p0, Lcom/rokid/phone/DeviceLinkerManager$$ExternalSyntheticLambda1;->f$1:Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

    iput-object p3, p0, Lcom/rokid/phone/DeviceLinkerManager$$ExternalSyntheticLambda1;->f$2:Lkotlin/jvm/functions/Function1;

    return-void
.end method


# virtual methods
.method public final invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3

    .line 0
    iget-object v0, p0, Lcom/rokid/phone/DeviceLinkerManager$$ExternalSyntheticLambda1;->f$0:Lcom/rokid/phone/DeviceLinkerManager;

    iget-object v1, p0, Lcom/rokid/phone/DeviceLinkerManager$$ExternalSyntheticLambda1;->f$1:Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

    iget-object v2, p0, Lcom/rokid/phone/DeviceLinkerManager$$ExternalSyntheticLambda1;->f$2:Lkotlin/jvm/functions/Function1;

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    invoke-static {v0, v1, v2, p1}, Lcom/rokid/phone/DeviceLinkerManager;->$r8$lambda$lvcdbfDKsijRDz0xpH0BggNyclI(Lcom/rokid/phone/DeviceLinkerManager;Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;Lkotlin/jvm/functions/Function1;Z)Lkotlin/Unit;

    move-result-object p1

    return-object p1
.end method
